import 'dart:convert';

import 'package:app_links/app_links.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:mi_fortitu/core/config/env_config.dart';
import 'package:mi_fortitu/core/di/dependency_injection.dart';
import 'package:mi_fortitu/core/services/url_launcher_service.dart';
import 'package:mi_fortitu/features/access/data/access_exception.dart';

import '../helpers/secure_storage_helper.dart';

enum RequestType { get, post, patch, delete }

/// IntraApiClient is a class that handles the communication with the Intra API.
/// It manages the OAuth2 authentication flow, token storage, and API requests.
/// It uses the AppLinks package to handle deep links and the http package for network requests.
/// It also uses the EnvConfig class to get the necessary environment variables for the API requests.
/// It uses the SecureStorageHelper class to securely store and retrieve tokens.
class IntraApiClient {
  final http.Client httpClient;
  final AppLinks appLinks;
  final UrlLauncherService launcher;
  final EnvConfig env;
  final SecureStorageHelper secureStorage;

  IntraApiClient(this.httpClient, this.appLinks, this.launcher, this.env, this.secureStorage);

  /// Checks if the user is logged in by checking if the access token is valid.
  Future<Either<Exception, Unit>> isLoggedIn() async {
    return await _getGrantedToken().then((result) {
      return result.fold((error) => Left(error), (_) => Right(unit));
    });
  }

  /// Gets the granted token for the user.
  /// If the token is expired or not available, it starts the OAuth2 flow to get a new token.
  /// Returns the access token if successful.
  Future<Either<Exception, String>> _getGrantedToken() async {
    final accessToken = await secureStorage.read('intra_access_token');
    final refreshToken = await secureStorage.read('intra_refresh_token');
    final expirationTimeStr = await secureStorage.read('intra_token_expiration');

    if (accessToken == null || refreshToken == null || expirationTimeStr == null) {
      return _startOAuth2Flow();
    }

    final expirationTime = DateTime.tryParse(expirationTimeStr);
    if (expirationTime == null) {
      return _startOAuth2Flow();
    }

    if (expirationTime.isAfter(DateTime.now())) {
      return Right(accessToken);
    }

    final newTokens = await _refreshToken(refreshToken);
    return await newTokens.fold((e) => _startOAuth2Flow(), (newTokens) async {
      await _saveTokens(newTokens);
      return Right(newTokens['access_token']);
    });
  }

  /// Starts the OAuth2 flow to get a new access token.
  /// It opens the authorization URL in the browser and listens for the redirect URI.
  /// It exchanges the authorization code for an access token and saves it securely.
  /// Returns the access token if successful.
  Future<Either<Exception, String>> _startOAuth2Flow() async {
    final response = await _requestNewTokens();
    return response.fold((e) => Left(Exception('OAuth2 authorization failed: $e')), (
      newTokens,
    ) async {
      await _saveTokens(newTokens);
      return Right(newTokens['access_token']);
    });
  }

  /// Requests new tokens by getting the authorization URL, launching it in the browser,
  /// listening for the redirect URI, and exchanging the authorization code for an access token.
  /// Returns the new tokens if successful.
  Future<Either<Exception, Map<String, dynamic>>> _requestNewTokens() async {
    // Check if the environment variables are set.
    final redirectUri = env.redirectUri;

    // Get the authorization URL from the server and launch it in the browser.
    final responseAuthUrl = await _getAuthorizationUrl();
    if (responseAuthUrl.isLeft()) {
      return Left(responseAuthUrl.fold((l) => l, (r) => throw UnimplementedError()));
    }
    final authUrl = responseAuthUrl.getOrElse(() => '');
    await launcher.redirect(Uri.parse(authUrl));

    // Listen for the redirect URI.
    final responseRedirectUrl = await _listenForRedirect(Uri.parse(redirectUri));
    if (responseRedirectUrl.isLeft()) {
      return Left(responseRedirectUrl.fold((l) => l, (r) => throw UnimplementedError()));
    }
    final responseUrl = responseRedirectUrl.getOrElse(() => Uri.parse(''));

    // Extract the authorization code and change it for an access token.
    final code = responseUrl.queryParameters['code'];
    if (code == null) {
      return Left(IntraException(code: 'AI04'));
    }

    final response = await supabaseClient.functions.invoke(
      'exchange-code-for-token',
      body: {'code': code},
    );

    if (response.status != 200) {
      return Left(IntraException(code: 'AI05', details: '${response.status}: ${response.data}'));
    }

    return Right(jsonDecode(response.data));
  }

  /// Gets the authorization URL for Intra authentication.
  /// It sends a request to the serverless function to get the URL.
  /// Returns the URL if successful.
  Future<Either<AccessException, String>> _getAuthorizationUrl() async {
    final tokenScope = env.intraTokenScope;
    final response = await supabaseClient.functions.invoke(
      'get-auth-url',
      body: {'scope': tokenScope},
    );

    if (response.status != 200) {
      return Left(IntraException(code: 'AI01', details: '${response.status}: ${response.data}'));
    }
    final data = jsonDecode(response.data);

    if (data['url'] == null) {
      return Left(IntraException(code: 'AI02'));
    }
    return Right(data['url']);
  }

  /// Listens for the redirect URL.
  /// It uses the AppLinks package to listen for deep links.
  /// Returns the redirect URL if successful.
  Future<Either<AccessException, Uri>> _listenForRedirect(Uri redirectUri) async {
    bool redirectProcessed = false;
    await for (final uri in appLinks.uriLinkStream) {
      if (redirectProcessed) {
        break;
      }
      if (uri.toString().startsWith(redirectUri.toString())) {
        redirectProcessed = true;
        return Right(uri);
      }
    }
    return Left(IntraException(code: 'AI03'));
  }

  /// Refreshes the access token using the refresh token.
  /// It sends a request to the serverless function to refresh the token.
  /// Returns the new tokens if successful.
  Future<Either<Exception, Map<String, dynamic>>> _refreshToken(String refreshToken) async {
    try {
      final response = await supabaseClient.functions.invoke(
        'refresh-token',
        body: {'refresh_token': refreshToken},
      );
      if (response.status != 200) {
        return Left(Exception('Failed to refresh token: ${response.status} ${response.data}'));
      }
      return Right(jsonDecode(response.data));
    } catch (e) {
      return Left(Exception('Failed to refresh token: $e'));
    }
  }

  /// Saves the access token, refresh token, and expiration time securely.
  /// It uses the SecureStorageHelper class to store the tokens.
  /// Returns a Unit if successful.
  Future<Either<Exception, Unit>> _saveTokens(Map<String, dynamic> data) async {
    final accessToken = data['access_token'];
    final refreshToken = data['refresh_token'];
    final expirationTime = DateTime.now().add(Duration(seconds: data['expires_in'] - 300));

    if (accessToken == null || refreshToken == null) {
      return Left(Exception('Invalid token data'));
    }
    try {
      await secureStorage.save('intra_access_token', accessToken);
      await secureStorage.save('intra_refresh_token', refreshToken);
      await secureStorage.save('intra_token_expiration', expirationTime.toIso8601String());
    } catch (e) {
      return Left(Exception('Failed to save tokens: $e'));
    }

    return Right(unit);
  }

  /// Logs out the user by clearing the access token, refresh token, and expiration time.
  /// It uses the SecureStorageHelper class to delete the tokens.
  /// Returns a Unit if successful.
  Future<Either<Exception, Unit>> logoutIntra() async {
    try {
      await secureStorage.delete('intra_access_token');
      await secureStorage.delete('intra_refresh_token');
      await secureStorage.delete('intra_token_expiration');
    } catch (e) {
      return Left(Exception('Failed to clear tokens: $e'));
    }
    return Right(unit);
  }

  /// Makes an API request to the Intra API.
  /// It handles the request type (GET, POST, PATCH, DELETE) and retries if necessary.
  /// It uses the http package to send the request and handles the response.
  /// Returns the response data if successful.
  Future<Either<Exception, dynamic>> _makeApiRequest(RequestType type, String route) async {
    final tokenResult = await _getGrantedToken();

    return tokenResult.fold((e) => Left(e), (accessToken) async {
      const maxRetries = 10;
      const delayDuration = Duration(milliseconds: 600);
      int retryCount = 0;

      while (retryCount < maxRetries) {
        try {
          final uri = Uri.parse(route);
          final headers = {'Authorization': 'Bearer $accessToken'};

          late http.Response response;

          switch (type) {
            case RequestType.get:
              response = await httpClient.get(uri, headers: headers);
              break;
            case RequestType.post:
              response = await httpClient.post(uri, headers: headers);
              break;
            case RequestType.patch:
              response = await httpClient.patch(uri, headers: headers);
              break;
            case RequestType.delete:
              response = await httpClient.delete(uri, headers: headers);
              break;
          }

          final code = response.statusCode;

          if (code == 429) {
            await Future.delayed(delayDuration);
            retryCount++;
            continue;
          }

          if (code == 401) {
            await secureStorage.delete('intra_access_token');
            await secureStorage.delete('intra_refresh_token');
            return Left(Exception('Token rejected by server. Need re-login.'));
          }

          if (code == 204) {
            return Right({});
          }

          if (code != 200 && code != 201) {
            return Left(Exception('Api Error(${response.statusCode}): ${response.body}'));
          }
          return Right(jsonDecode(response.body));
        } catch (e) {
          return Left(Exception('Api Request Error: ${e.toString()}'));
        }
      }
      return Left(Exception('Max retries reached for API request'));
    });
  }

  /// Makes a GET request to the Intra API to get the token information.
  /// Returns the token information if successful.
  Future<Either<Exception, dynamic>> getTokenInfo() async {
    final url = 'https://api.intra.42.fr/oauth/token';
    return await _makeApiRequest(RequestType.get, url);
  }

  /// Makes a GET request to the Intra API to get the user information.
  /// Returns the user information if successful.
  Future<Either<Exception, Map<String, dynamic>>> getUser(String loginName) async {
    late final String url;
    loginName == 'me'
        ? url = 'https://api.intra.42.fr/v2/me'
        : url = 'https://api.intra.42.fr/v2/users/$loginName';

    final response = await _makeApiRequest(RequestType.get, url);
    return response.fold((exception) => Left(exception), (data) {
      try {
        return Right(data as Map<String, dynamic>);
      } catch (e) {
        return Left(Exception('Exception getting User: ${e.toString()}'));
      }
    });
  }

  /// Makes a GET request to the Intra API to get the user events.
  /// Returns the user events if successful.
  Future<Either<Exception, List<dynamic>>> getUserEvents(String loginName) async {
    late final String url;
    loginName == 'me'
        ? url = 'https://api.intra.42.fr/v2/me'
        : url = 'https://api.intra.42.fr/v2/users/$loginName/events_users';

    final response = await _makeApiRequest(RequestType.get, url);
    return response.fold((exception) => Left(exception), (data) {
      try {
        final events = (data as List).map((event) => event as Map<String, dynamic>).toList();
        return Right(events);
      } catch (e) {
        return Left(Exception('Exception getting User Events: ${e.toString()}'));
      }
    });
  }

  /// Makes a GET request to the Intra API to get the campus events.
  /// Returns a list of campus events if successful.
  Future<Either<Exception, List<dynamic>>> getCampusEvents(int campusId) async {
    final url = 'https://api.intra.42.fr/v2/campus/$campusId/events';
    final response = await _makeApiRequest(RequestType.get, url);
    return response.fold((exception) => Left(exception), (data) {
      try {
        final events = (data as List).map((event) => event as Map<String, dynamic>).toList();
        return Right(events);
      } catch (e) {
        return Left(Exception('Exception getting Campus Events: ${e.toString()}'));
      }
    });
  }

  /// Makes a GET request to the Intra API to get the campus locations.
  /// It handles pagination to get all locations.
  /// Returns a list of campus locations if successful.
  Future<Either<Exception, List<Map<String, dynamic>>>> getCampusLocations(String campusId) async {
    final baseRoute = 'https://api.intra.42.fr/v2/campus/$campusId/locations';
    const int pageSize = 100;
    int pageNumber = 1;
    List<Map<String, dynamic>> allUsers = [];

    while (true) {
      final url = '$baseRoute?filter[active]=true&page[number]=$pageNumber&page[size]=$pageSize';
      final response = await _makeApiRequest(RequestType.get, url);
      if (response.isLeft()) {
        return Left(response.fold((exception) => exception, (r) => Exception('Error')));
      }
      final data = response.getOrElse(() => []).cast<Map<String, dynamic>>();
      if (data.isEmpty) {
        break;
      }
      allUsers.addAll(data);
      if (data.length < pageSize) {
        break;
      }
      pageNumber++;
    }
    return Right(allUsers);
  }

  /// Makes a GET request to the Intra API to get the campus coalitions.
  /// Returns a list of cursus coalitions of the campus if successful.
  Future<Either<Exception, List<dynamic>>> getCampusBlocs(int campusId) async {
    final url = 'https://api.intra.42.fr/v2/blocs/';
    final filters = '?filter[campus_id]=$campusId';
    final response = await _makeApiRequest(RequestType.get, '$url$filters');
    return response.fold((exception) => Left(exception), (data) {
      try {
        return Right(data as List<dynamic>);
      } catch (e) {
        return Left(Exception('Exception getting Campus Coalitions: ${e.toString()}'));
      }
    });
  }

  /// Makes a GET request to the Intra API to get the project users.
  /// It handles pagination to get all users.
  /// Returns a list of project users if successful.
  Future<Either<Exception, List<Map<String, dynamic>>>> getProjectUsers(
    int projectId,
    int campusId,
  ) async {
    final url = 'https://api.intra.42.fr/v2/projects/$projectId/projects_users';

    const int pageSize = 100;
    int pageNumber = 1;
    List<Map<String, dynamic>> allUsers = [];

    while (true) {
      final filters = '?filter[campus]=$campusId&filter[status]=in_progress&filter[marked]=false';
      final pagination = '&page[number]=$pageNumber&page[size]=$pageSize';

      final response = await _makeApiRequest(RequestType.get, '$url$filters$pagination');
      if (response.isLeft()) {
        return Left(response.fold((exception) => exception, (r) => Exception('Error')));
      }
      try {
        final data = response.getOrElse(() => []);
        if (data is! List) {
          return Left(Exception('Unexpected data format: expected a List'));
        }

        final userList =
            data
                .map((item) => (item as Map<String, dynamic>)['user'] as Map<String, dynamic>)
                .toList();

        if (userList.isEmpty) break;
        allUsers.addAll(userList);
        if (userList.length < pageSize) break;

        pageNumber++;
      } catch (e) {
        return Left(Exception('Exception getting Project Users: ${e.toString()}'));
      }
    }
    return Right(allUsers);
  }

  /// Makes a GET request to the Intra API to get the user evaluations.
  /// It handles pagination to get all evaluations.
  /// Returns a list of user evaluations if successful.
  Future<Either<Exception, List<dynamic>>> getUserEvaluations(String loginName) async {
    final user = loginName == 'me' ? await getUser('me') : await getUser('users/$loginName');
    final url = 'https://api.intra.42.fr/v2/$user/slots';
    final filters = '?filter[future]=false&filter[end]=false';

    final response = await _makeApiRequest(RequestType.get, '$url$filters');
    return response.fold((exception) => Left(exception), (data) {
      try {
        final slots = (data as List).map((slot) => slot as Map<String, dynamic>).toList();
        return Right(slots);
      } catch (e) {
        return Left(Exception('Exception getting User Slots: ${e.toString()}'));
      }
    });
  }

  /// Makes a GET request to the Intra API to get the user projects.
  /// It handles pagination to get all projects.
  /// Returns a list of user projects if successful.
  Future<Either<Exception, List<dynamic>>> getUserProjects(String loginName) async {
    final user = loginName == 'me' ? await getUser('me') : await getUser('users/$loginName');
    final url = 'https://api.intra.42.fr/v2/$user/projects_users';
    final filters = '?filter[marked]=false';

    final response = await _makeApiRequest(RequestType.get, '$url$filters');
    return response.fold((exception) => Left(exception), (data) {
      try {
        final projects = (data as List).map((project) => project as Map<String, dynamic>).toList();

        return Right(projects);
      } catch (e) {
        return Left(Exception('Exception getting User Projects: ${e.toString()}'));
      }
    });
  }

  /// Makes a POST request to the Intra API to subscribe to an event.
  /// Returns the event data if successful.
  Future<Either<Exception, Map<String, int>>> subscribeToEvent({
    required int userId,
    required int eventId,
  }) async {
    final url = 'https://api.intra.42.fr/v2/events_users';
    final filters = '?events_user[user_id]=$userId&events_user[event_id]=$eventId';

    final response = await _makeApiRequest(RequestType.post, '$url$filters');
    return response.fold((exception) => Left(exception), (data) {
      try {
        return Right({
          'id': data['id'] as int,
          'event_id': data['event_id'] as int,
          'user_id': data['user_id'] as int,
        });
      } catch (e) {
        return Left(Exception('Exception subscribing to Event: ${e.toString()}'));
      }
    });
  }

  /// Makes a DELETE request to the Intra API to unsubscribe from an event.
  /// Returns a Unit if successful.
  Future<Either<Exception, Unit>> unsubscribeFromEvent(int eventUserId) async {
    final url = 'https://api.intra.42.fr/v2/events_users/$eventUserId';

    final response = await _makeApiRequest(RequestType.delete, url);
    return response.fold((exception) => Left(exception), (data) {
      try {
        return Right(unit);
      } catch (e) {
        return Left(Exception('Exception unsubscribing from Event: ${e.toString()}'));
      }
    });
  }

  /// Makes a GET request to the Intra API to get the user slots.
  /// It handles pagination to get all slots.
  /// Returns a list of user slots if successful.
  Future<Either<Exception, List<dynamic>>> getUserSlots(String loginName) async {
    late String url;
    loginName == 'me' ? url = 'https://api.intra.42.fr/v2/$loginName/slots' : url = '';

    final filters = '?filter[future]=true';
    final response = await _makeApiRequest(RequestType.get, '$url$filters');

    return response.fold((exception) => Left(exception), (data) {
      try {
        if (data is! List) {
          throw Exception('Expected List but got ${data.runtimeType}');
        }
        final slots = data.map((slot) {
          if (slot is! Map<String, dynamic>) {
            throw Exception('Slot is not a Map: ${slot.runtimeType}');
          }
          return slot;
        }).toList();
        return Right(slots);
      } catch (e) {
        return Left(Exception('Exception getting User Slots: ${e.toString()}'));
      }
    });
  }

  /// Makes a POST request to the Intra API to create an evaluation slot.
  /// Returns the created slot data if successful.
  Future<Either<Exception, List<dynamic>>> createEvaluationSlot({
    required int userId,
    required DateTime begin,
    required DateTime end,
  }) async {
    final url = 'https://api.intra.42.fr/v2/slots';
    final filters = '?slot[user_id]=$userId&slot[begin_at]=$begin&slot[end_at]=$end';

    final response = await _makeApiRequest(RequestType.post, '$url$filters');
    return response.fold((exception) => Left(exception), (data) {
      try {
        final coalitions = (data as List).map((slot) => slot as Map<String, dynamic>).toList();
        return Right(coalitions);
      } catch (e) {
        return Left(Exception('Exception creating Evaluation Slots: ${e.toString()}'));
      }
    });
  }

  /// Makes a DELETE request to the Intra API to destroy an evaluation slot.
  /// Returns a Unit if successful.
  Future<Either<Exception, Unit>> destroyEvaluationSlot(int slotId) async {
    final url = 'https://api.intra.42.fr/v2/slots/$slotId';

    final response = await _makeApiRequest(RequestType.delete, url);
    return response.fold((exception) => Left(exception), (data) {
      try {
        return Right(unit);
      } catch (e) {
        return Left(Exception('Exception destroying Evaluation Slot: ${e.toString()}'));
      }
    });
  }

  /// Makes a GET request to the Intra API to get the scale team slots.
  /// Returns the slot evaluation data if successful.
  /// For students, returns a string until there are 15 minutes left until the evaluation.
  Future<Either<Exception, List<dynamic>>> destroySlotsWithScaleTeam(int scaleTeamId) async {
    final url = 'https://api.intra.42.fr/v2/scale_teams/$scaleTeamId';

    final response = await _makeApiRequest(RequestType.get, url);
    return response.fold((exception) => Left(exception), (data) {
      try {
        final slots = (data as List).map((slot) => slot as Map<String, dynamic>).toList();
        return Right(slots);
      } catch (e) {
        return Left(Exception('Exception deleting Scale Team Slots: ${e.toString()}'));
      }
    });
  }
}

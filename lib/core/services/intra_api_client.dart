import 'dart:convert';

import 'package:app_links/app_links.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:mi_fortitu/core/config/env_config.dart';
import 'package:mi_fortitu/core/services/url_launcher_service.dart';
import 'package:mi_fortitu/features/access/data/access_exception.dart';

import '../helpers/secure_storage_helper.dart';

class IntraApiClient {
  final http.Client httpClient;
  final AppLinks appLinks;
  final UrlLauncherService launcher;
  final EnvConfig env;
  final SecureStorageHelper secureStorage;

  IntraApiClient(this.httpClient, this.appLinks, this.launcher, this.env, this.secureStorage);

  Future<Either<Exception, String>> getGrantedToken() async {
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

  Future<Either<Exception, String>> _startOAuth2Flow() async {
    final response = await requestNewTokens();
    return response.fold(
      (e) => Left(Exception('OAuth2 authorization failed: $e')),
      (newTokens) async {
        await _saveTokens(newTokens);
        return Right(newTokens['access_token']);
      },
    );
  }

  Future<Either<Exception, Map<String, dynamic>>> requestNewTokens() async {
    // Check if the environment variables are set.
    final redirectUri = env.redirectUri;
    final codeForTokenFunctionUrl = env.codeForTokenFunctionUrl;

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
    final response = await httpClient.post(
      Uri.parse(codeForTokenFunctionUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'code': code}),
    );
    if (response.statusCode != 200) {
      return Left(
        IntraException(code: 'AI05', details: '${response.statusCode}: ${response.body}'),
      );
    }

    return Right(jsonDecode(response.body));
  }

  /// Gets the authorization URL for Intra authentication.
  Future<Either<AccessException, String>> _getAuthorizationUrl() async {
    final getAuthUrlFunctionUrl = env.getAuthUrlFunctionUrl;
    final tokenScope = env.intraTokenScope;

    final response = await httpClient.post(
      Uri.parse(getAuthUrlFunctionUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'scope': tokenScope}),
    );

    if (response.statusCode != 200) {
      return Left(
        IntraException(code: 'AI01', details: '${response.statusCode}: ${response.body}'),
      );
    }

    final data = jsonDecode(response.body);

    if (data['url'] == null) {
      return Left(IntraException(code: 'AI02'));
    }

    return Right(data['url']);
  }

  /// Listens for the redirect URL.
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

  Future<Either<Exception, Map<String, dynamic>>> _refreshToken(String refreshToken) async {
    final refreshTokenFunctionUrl = env.refreshTokenFunctionUrl;
    final response = await httpClient.post(
      Uri.parse(refreshTokenFunctionUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'refresh_token': refreshToken}),
    );
    if (response.statusCode != 200) {
      return Left(Exception('Failed to refresh token: ${response.statusCode} ${response.body}'));
    }
    return jsonDecode(response.body);
  }

  Future<Either<Exception, Unit>> _saveTokens(Map<String, dynamic> data) async {
    final accessToken = data['access_token'];
    final refreshToken = data['refresh_token'];
    final expirationTime = DateTime.now().add(Duration(seconds: data['expires_in'] - 30));

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

  Future<Either<Exception, dynamic>> _makeGetRequest(String route) async {
    final tokenResult = await getGrantedToken();

    return tokenResult.fold((e) => Left(e), (accessToken) async {
      try {
        final response = await httpClient.get(
          Uri.parse(route),
          headers: {'Authorization': 'Bearer $accessToken'},
        );

        if (response.statusCode == 401) {
          await secureStorage.delete('intra_access_token');
          await secureStorage.delete('intra_refresh_token');
          return Left(Exception('Token rejected by server. Need re-login.'));
        }

        if (response.statusCode != 200) {
          return Left(Exception('Api Error(${response.statusCode}): ${response.body}'));
        }
        return Right(jsonDecode(response.body));
      } catch (e) {
        return Left(Exception('Api Request Error: ${e.toString()}'));
      }
    });
  }

  Future<Either<Exception, dynamic>> getTokenInfo() async {
    final url = 'https://api.intra.42.fr/oauth/token';
    return await _makeGetRequest(url);
  }

  Future<Either<Exception, Map<String, dynamic>>> getUser(String loginName) async {
    late final String url;
    loginName == 'me'
        ? url = 'https://api.intra.42.fr/v2/me'
        : url = 'https://api.intra.42.fr/v2/users/$loginName';

    final response = await _makeGetRequest(url);
    return response.fold((exception) => Left(exception), (data) {
      try {
        return Right(data as Map<String, dynamic>);
      } catch (e) {
        return Left(Exception('Exception getting User: ${e.toString()}'));
      }
    });
  }

  Future<Either<Exception, List<dynamic>>> getUserEvents(String loginName) async {
    late final String url;
    loginName == 'me'
        ? url = 'https://api.intra.42.fr/v2/me'
        : url = 'https://api.intra.42.fr/v2/users/$loginName/events_users';

    final response = await _makeGetRequest(url);
    return response.fold((exception) => Left(exception), (data) {
      try {
        final events =
            (data as List).map((event) => event['event'] as Map<String, dynamic>).toList();
        return Right(events);
      } catch (e) {
        return Left(Exception('Exception getting User Events: ${e.toString()}'));
      }
    });
  }

  Future<Either<Exception, List<dynamic>>> getCampusEvents(String campusId) async {
    final url = 'https://api.intra.42.fr/v2/campus/$campusId/events';
    final response = await _makeGetRequest(url);
    return response.fold((exception) => Left(exception), (data) {
      try {
        final events = (data as List).map((event) => event as Map<String, dynamic>).toList();
        return Right(events);
      } catch (e) {
        return Left(Exception('Exception getting Campus Events: ${e.toString()}'));
      }
    });
  }

  Future<Either<Exception, List<Map<String, dynamic>>>> getCampusLocations(String campusId) async {
    final baseRoute = 'https://api.intra.42.fr/v2/campus/$campusId/locations';
    const int pageSize = 100;
    int pageNumber = 1;
    List<Map<String, dynamic>> allUsers = [];

    while (true) {
      final url = '$baseRoute?filter[active]=true&page=$pageNumber&per_page=$pageSize';
      final response = await _makeGetRequest(url);
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

  Future<Either<Exception, List<dynamic>>> getCampusBlocs(String campusId) async {
    final url = 'https://api.intra.42.fr/v2/blocs/';
    final filters = '?filter[campus_id]=$campusId';
    final response = await _makeGetRequest('$url$filters');
    return response.fold((exception) => Left(exception), (data) {
      try {
        return Right(data as List<dynamic>);
      } catch (e) {
        return Left(Exception('Exception getting Campus Coalitions: ${e.toString()}'));
      }
    });
  }

  Future<Either<Exception, List<Map<String, dynamic>>>> getProjectUsers(
    int projectId,
    int campusId,
  ) async {
    final url = 'https://api.intra.42.fr/v2/projects/$projectId/projects_users';
    final filters = '?filter[campus]=$campusId&filter[status]=in_progress&filter[marked]=false';
    final response = await _makeGetRequest('$url$filters');

    return response.fold((exception) => Left(exception), (data) {
      try {
        final list = data as List;
        final userList =
            list
                .map((user) => (user as Map<String, dynamic>)['user'] as Map<String, dynamic>)
                .toList();
        return Right(userList);
      } catch (e) {
        return Left(Exception('Exception getting Intra Project Users: ${e.toString()}'));
      }
    });
  }
}

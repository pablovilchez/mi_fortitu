import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:mi_fortitu/core/config/env_config.dart';

import '../helpers/secure_storage_helper.dart';

class IntraApiClient {
  final http.Client httpClient;
  final EnvConfig env;
  final SecureStorageHelper secureStorage;

  IntraApiClient(this.httpClient, this.env, this.secureStorage);

  Future<Either<Exception, String>> getGrantedToken() async {
    try {
      final accessToken = await secureStorage.read('intra_access_token');
      final intraRefreshToken = await secureStorage.read('intra_refresh_token');
      final expirationTimeStr = await secureStorage.read('intra_token_expiration');

      if (accessToken == null || intraRefreshToken == null || expirationTimeStr == null) {
        return Left(Exception('No access token found in storage. Please log in again.'));
      }
      final expirationTime = DateTime.parse(expirationTimeStr);
      if (expirationTime.isBefore(DateTime.now())) {
        final newTokens = await _refreshToken(intraRefreshToken);
        await saveTokens(newTokens);
        return Right(newTokens['access_token']);
      }
      return Right(accessToken);
    } catch (e) {
      return Left(Exception(e));
    }
  }

  Future<Either<Exception, Unit>> saveTokens(Map<String, dynamic> data) async {
    final accessToken = data['access_token'];
    final refreshToken = data['refresh_token'];
    final expirationTime = DateTime.now().add(Duration(seconds: data['expires_in']));

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

  Future<Map<String, dynamic>> _refreshToken(String refreshToken) async {
    final refreshTokenFunctionUrl = env.refreshTokenFunctionUrl;
    final response = await httpClient.post(
      Uri.parse(refreshTokenFunctionUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'refresh_token': refreshToken}),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to refresh token: ${response.statusCode} ${response.body}');
    }
    return jsonDecode(response.body);
  }

  Future<Either<Exception, dynamic>> _makeGetRequest(String route) async {
    final token = await getGrantedToken();

    return token.fold((exception) => Left(exception), (accessToken) async {
      try {
        final response = await httpClient.get(
          Uri.parse(route),
          headers: {'Authorization': 'Bearer $accessToken'},
        );
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

  Future<Either<Exception, List<dynamic>>> getProjectUsers(
    String projectId,
    String campusId,
  ) async {
    final url = 'https://api.intra.42.fr/v2/projects/$projectId/project_users';
    final filters = '?filter[campus]=$campusId&filter[status]=in_progress&filter[marked]=false';
    final response = await _makeGetRequest('$url$filters');
    return response.fold((exception) => Left(exception), (data) {
      try {
        return Right(data as List<dynamic>);
      } catch (e) {
        return Left(Exception('Exception getting Intra Project Users: ${e.toString()}'));
      }
    });
  }
}

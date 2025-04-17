import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:mi_fortitu/core/config/env_config.dart';

import '../errors/exceptions.dart';
import '../helpers/secure_storage_helper.dart';

class IntraApiService {
  final http.Client httpClient;
  final EnvConfig env;
  final SecureStorageHelper secureStorage;

  IntraApiService({required this.httpClient, required this.env, required this.secureStorage});

  Future<Either<Exception, Map<String, dynamic>>> getTokenInfo(String accessToken) async {
    final intraTokenUrl = 'https://api.intra.42.fr/oauth/token';
    final response = await httpClient.get(
      Uri.parse(intraTokenUrl),
      headers: {'Authorization': 'Bearer $accessToken'},
    );

    if (response.statusCode != 200) {
      return Left(Exception('Failed to get token info: ${response.statusCode} ${response.body}'));
    }

    return Right(jsonDecode(response.body));
  }

  Future<Either<Exception, Unit>> saveTokens(Map<String, dynamic> data) async {
    final accessToken = data['access_token'];
    final refreshToken = data['refresh_token'];
    final expirationTime = DateTime.now().add(Duration(seconds: data['expires_in']));

    if (accessToken == null || refreshToken == null) {
      return Left(SaveTokenException('Invalid token data'));
    }
    try {
      await secureStorage.save('intra_access_token', accessToken);
      await secureStorage.save('intra_refresh_token', refreshToken);
      await secureStorage.save('intra_token_expiration', expirationTime.toIso8601String());
    } catch (e) {
      return Left(SaveTokenException('Failed to save tokens: $e'));
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
}

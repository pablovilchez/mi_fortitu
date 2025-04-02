import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import '../../features/auth/domain/failures.dart';
import '../helpers/secure_storage_helper.dart';

class IntraApiService {
  final http.Client httpClient;
  final Map<String, String> env;
  final SecureStorageHelper secureStorage;

  IntraApiService({required this.httpClient, required this.env, required this.secureStorage});

  Future<Map<String, dynamic>> getTokenInfo(String accessToken) async {
    final intraTokenUrl = env['INTRA_TOKEN_URL'];
    final response = await httpClient.get(
      Uri.parse(intraTokenUrl!),
      headers: {'Authorization': 'Bearer $accessToken'},
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to get token info: ${response.body}');
    }

    return jsonDecode(response.body);
  }

  Future<void> saveTokens(Map<String, dynamic> data) async {
    final accessToken = data['access_token'];
    final refreshToken = data['refresh_token'];
    final expirationTime = DateTime.now().add(Duration(seconds: data['expires_in']));

    if (accessToken == null || refreshToken == null) {
      throw Exception('Failed to save tokens: Access token or refresh token is null');
    }
    await secureStorage.save('intra_access_token', accessToken);
    await secureStorage.save('intra_refresh_token', refreshToken);
    await secureStorage.save('intra_token_expiration', expirationTime.toIso8601String());
  }

  Future<Map<String, dynamic>> refreshToken(String refreshToken) async {
    final refreshTokenFunctionUrl = env['REFRESH_TOKEN_FUNCTION_URL'];
    final response = await httpClient.post(
      Uri.parse(refreshTokenFunctionUrl!),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'grant_type': 'refresh_token', 'refresh_token': refreshToken}),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to refresh token: ${response.body}');
    }
    return jsonDecode(response.body);
  }

  Future<Either<Failure, String>> getGrantedToken() async {
    try {
      final accessToken = await secureStorage.read('intra_access_token');
      final expirationTimeStr = await secureStorage.read('intra_token_expiration');
      if (accessToken == null || expirationTimeStr == null) {
        return Left(IntraLoginFailure('No valid access token found'));
      }
      final expirationTime = DateTime.parse(expirationTimeStr);
      if (expirationTime.isBefore(DateTime.now())) {
        final intraRefreshToken = await secureStorage.read('intra_refresh_token');
        if (intraRefreshToken == null) {
          return Left(IntraLoginFailure('No refresh token found'));
        }
        final newTokens = await refreshToken(intraRefreshToken);
        await saveTokens(newTokens);
        return newTokens['access_token'];
      }
      return Right(accessToken);
    } catch (e) {
      return Left(IntraLoginFailure('Failed to get access token: $e'));
    }
  }
}

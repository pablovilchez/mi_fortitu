import 'package:app_links/app_links.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mi_fortitu/core/services/url_launcher_service.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;
import 'package:mi_fortitu/features/auth/data/datasources/auth_intra_datasource.dart';
import 'dart:convert';

class MockHttpClient extends Mock implements http.Client {}
class MockAppLinks extends Mock implements AppLinks {}
class MockUrlLauncherService extends Mock implements UrlLauncherService {}
class MockEnv extends Mock implements Map<String, String> {}

void main() {
  late MockHttpClient mockHttpClient;
  late MockAppLinks mockAppLinks;
  late MockUrlLauncherService mockUrlLauncherService;
  late Map<String, String> mockEnv;
  late AuthIntraDatasource datasource;

  setUp(() {
    mockHttpClient = MockHttpClient();
    mockAppLinks = MockAppLinks();
    mockUrlLauncherService = MockUrlLauncherService();
    mockEnv = {
      'REFRESH_TOKEN_FUNCTION_URL': 'https://example.com/refresh',
      'INTRA_TOKEN_URL': 'https://example.com/token',
      'OAUTH_CODE_FUNCTION_URL': 'https://example.com/oauth',
      'AUTH_FUNCTION_URL': 'https://example.com/auth',
      'REDIRECT_URI': 'https://example.com/redirect',
    };
    datasource = AuthIntraDatasource(
      httpClient: mockHttpClient,
      appLinks: mockAppLinks,
      launcher: mockUrlLauncherService,
      env: mockEnv,
    );
  });

  group('AuthIntraDatasource', () {
    const tRefreshToken = 'dummy_refresh_token';
    const tAccessToken = 'dummy_access_token';
    const tJsonResponse = '{"access_token": "$tAccessToken", "refresh_token": "$tRefreshToken", "expires_in": 3600}';

    test('should return a valid Map<String, dynamic> when refreshToken is called successfully', () async {
      // Arrange
      when(() => mockHttpClient.post(
        Uri.parse(mockEnv['REFRESH_TOKEN_FUNCTION_URL']!),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'grant_type': 'refresh_token',
          'refresh_token': tRefreshToken,
        }),
      )).thenAnswer((_) async => http.Response(tJsonResponse, 200));

      // Act
      final result = await datasource.refreshToken(tRefreshToken);

      // Assert
      expect(result, isA<Map<String, dynamic>>());
      expect(result['access_token'], tAccessToken);
      expect(result['refresh_token'], tRefreshToken);
      expect(result['expires_in'], 3600);
    });

    test('should throw an Exception when refreshToken fails', () async {
      // Arrange
      when(() => mockHttpClient.post(
        Uri.parse(mockEnv['REFRESH_TOKEN_FUNCTION_URL']!),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'grant_type': 'refresh_token',
          'refresh_token': tRefreshToken,
        }),
      )).thenAnswer((_) async => http.Response('Failed', 400));

      // Act & Assert
      expect(() async => await datasource.refreshToken(tRefreshToken), throwsException);
    });

    test('should return a valid Map<String, dynamic> when getTokenInfo is called successfully', () async {
      // Arrange
      when(() => mockHttpClient.get(
        Uri.parse(mockEnv['INTRA_TOKEN_URL']!),
        headers: {'Authorization': 'Bearer $tAccessToken'},
      )).thenAnswer((_) async => http.Response(tJsonResponse, 200));

      // Act
      final result = await datasource.getTokenInfo(tAccessToken);

      // Assert
      expect(result, isA<Map<String, dynamic>>());
      expect(result['access_token'], tAccessToken);
      expect(result['refresh_token'], tRefreshToken);
      expect(result['expires_in'], 3600);
    });

    test('should throw an Exception when getTokenInfo fails', () async {
      // Arrange
      when(() => mockHttpClient.get(
        Uri.parse(mockEnv['INTRA_TOKEN_URL']!),
        headers: {'Authorization': 'Bearer $tAccessToken'},
      )).thenAnswer((_) async => http.Response('Failed', 400));

      // Act & Assert
      expect(() async => await datasource.getTokenInfo(tAccessToken), throwsException);
    });
  });
}

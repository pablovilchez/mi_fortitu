import 'package:app_links/app_links.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mi_fortitu/core/config/env_config.dart';
import 'package:mi_fortitu/core/services/url_launcher_service.dart';
import 'package:mi_fortitu/features/auth/data/datasources/auth_intra_datasource.dart';
import 'package:mi_fortitu/features/auth/data/auth_exception.dart';
import 'package:mocktail/mocktail.dart';

class MockHttpClient extends Mock implements http.Client {}

class MockAppLinks extends Mock implements AppLinks {}

class MockUrlLauncherService extends Mock implements UrlLauncherService {}

class MockEnvConfig extends Mock implements EnvConfig {}

void main() {
  late MockHttpClient mockHttpClient;
  late MockAppLinks mockAppLinks;
  late MockUrlLauncherService mockUrlLauncherService;
  late MockEnvConfig mockEnv;
  late AuthIntraDatasource datasource;

  setUp(() {
    mockHttpClient = MockHttpClient();
    mockAppLinks = MockAppLinks();
    mockUrlLauncherService = MockUrlLauncherService();
    mockEnv = MockEnvConfig();

    when(() => mockEnv.getAuthUrlFunctionUrl).thenReturn('https://example.com/oauth');
    when(() => mockEnv.codeForTokenFunctionUrl).thenReturn('https://example.com/auth');
    when(() => mockEnv.redirectUri).thenReturn('https://example.com/redirect');
    when(() => mockEnv.intraTokenScope).thenReturn('example_scope');

    datasource = AuthIntraDatasource(
      httpClient: mockHttpClient,
      appLinks: mockAppLinks,
      launcher: mockUrlLauncherService,
      env: mockEnv,
    );

    registerFallbackValue(Uri.parse('https://example.com/redirect'));
  });

  group('requestNewToken', () {
    const tAuthUrl = 'https://example.com/auth-url';
    const tRequestUrlResponse = '{"url": "$tAuthUrl"}';
    const tAccessTokenResponse = '{"access_token": "test_token"}';

    test('returns a valid Map<String, dynamic> when new token is requested successfully', () async {
      // Arrange
      when(
        () => mockHttpClient.post(any(), headers: any(named: 'headers'), body: contains('scope')),
      ).thenAnswer((_) async => http.Response(tRequestUrlResponse, 200));

      when(() => mockUrlLauncherService.redirect(any())).thenAnswer((_) async {});

      when(
        () => mockAppLinks.uriLinkStream,
      ).thenAnswer((_) => Stream.value(Uri.parse('https://example.com/redirect?code=valid_code')));

      when(
        () => mockHttpClient.post(any(), headers: any(named: 'headers'), body: contains('code')),
      ).thenAnswer((_) async => http.Response(tAccessTokenResponse, 200));

      // Act
      final result = await datasource.requestNewTokens();

      // Assert
      expect(result.isRight(), isTrue);
      expect(result.getOrElse(() => {}), equals({"access_token": "test_token"}));
    });
    group('requestNewToken errors', () {
      test('returns EnvException when environment variables are missing', () async {
        expect(
          () => AuthIntraDatasource(
            httpClient: mockHttpClient,
            appLinks: mockAppLinks,
            launcher: mockUrlLauncherService,
            env: EnvConfig.from({}),
          ),
          throwsA(isA<EnvException>()),
        );
      });

      test('returns UrlException when authorization URL request fails', () async {
        when(
          () =>
              mockHttpClient.post(any(), headers: any(named: 'headers'), body: any(named: 'body')),
        ).thenAnswer((_) async => http.Response('Error', 400));

        final result = await datasource.requestNewTokens();

        expect(result.isLeft(), isTrue);
        expect(result.swap().getOrElse(() => UrlException()), isA<UrlException>());
      });

      test(
        'returns NoCodeException when authorization code is not present in redirect URL',
        () async {
          when(
            () =>
                mockHttpClient.post(any(), headers: any(named: 'headers'), body: contains('scope')),
          ).thenAnswer((_) async => http.Response(tRequestUrlResponse, 200));

          when(() => mockUrlLauncherService.redirect(any())).thenAnswer((_) async {});

          when(
            () => mockAppLinks.uriLinkStream,
          ).thenAnswer((_) => Stream.value(Uri.parse('https://example.com/redirect')));

          final result = await datasource.requestNewTokens();

          expect(result.isLeft(), isTrue);
          expect(result.swap().getOrElse(() => NoCodeException()), isA<NoCodeException>());
        },
      );

      test('returns TokenExchangeException when token exchange request fails', () async {
        when(
          () => mockHttpClient.post(any(), headers: any(named: 'headers'), body: contains('scope')),
        ).thenAnswer((_) async => http.Response(tRequestUrlResponse, 200));

        when(() => mockUrlLauncherService.redirect(any())).thenAnswer((_) async {});

        when(() => mockAppLinks.uriLinkStream).thenAnswer(
          (_) => Stream.value(Uri.parse('https://example.com/redirect?code=valid_code')),
        );

        when(
          () => mockHttpClient.post(any(), headers: any(named: 'headers'), body: contains('code')),
        ).thenAnswer((_) async => http.Response('Error', 400));

        final result = await datasource.requestNewTokens();

        expect(result.isLeft(), isTrue);
        expect(
          result.swap().getOrElse(() => TokenExchangeException()),
          isA<TokenExchangeException>(),
        );
      });
    });
  });
}

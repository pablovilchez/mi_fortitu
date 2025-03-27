import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mi_fortitu/features/auth/data/datasources/auth_intra_datasource.dart';
import 'package:oauth2/oauth2.dart' as oauth2;

class MockSecureStorageHelper extends Mock {
  Future<String?> getIntraAccessToken();
  Future<String?> getIntraRefreshToken();
  Future<void> saveIntraTokens(String accessToken, String refreshToken);
}

class MockOauth2Client extends Mock implements oauth2.Client {}

void main() {
  late AuthIntraDatasource datasource;
  late MockSecureStorageHelper mockStorage;

  setUp(() {
    mockStorage = MockSecureStorageHelper();
    datasource = AuthIntraDatasource();
  });

  test('Returns a valid OAuth2 client if tokens are already stored', () async {
    when(() => mockStorage.getIntraAccessToken()).thenAnswer((_) async => 'access_token');
    when(() => mockStorage.getIntraRefreshToken()).thenAnswer((_) async => 'refresh_token');

    final client = await datasource.getIntraClient();

    expect(client, isA<oauth2.Client>());
    verify(() => mockStorage.getIntraAccessToken()).called(1);
    verify(() => mockStorage.getIntraRefreshToken()).called(1);
  });

  test('Launches an exception if no stored credentials and authentication fails', () {
    when(() => mockStorage.getIntraAccessToken()).thenAnswer((_) async => null);
    when(() => mockStorage.getIntraRefreshToken()).thenAnswer((_) async => null);

    expect(() => datasource.getIntraClient(), throwsException);
  });
}

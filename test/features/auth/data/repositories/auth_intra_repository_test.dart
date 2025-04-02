import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mi_fortitu/core/helpers/secure_storage_helper.dart';
import 'package:mi_fortitu/features/auth/data/datasources/auth_intra_datasource.dart';
import 'package:mi_fortitu/features/auth/data/repositories/auth_intra_repository_impl.dart';
import 'package:mi_fortitu/features/auth/domain/failures.dart';
import 'package:mi_fortitu/features/auth/domain/repositories/auth_intra_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockIntraAuthDatasource extends Mock implements AuthIntraDatasource {}

class MockSecureStorageHelper extends Mock implements SecureStorageHelper {}

void main() {
  late AuthIntraRepository repository;
  late MockIntraAuthDatasource mockDatasource;
  late MockSecureStorageHelper mockSecureStorage;

  setUp(() {
    mockDatasource = MockIntraAuthDatasource();
    mockSecureStorage = MockSecureStorageHelper();
    repository = AuthIntraRepositoryImpl(mockDatasource, mockSecureStorage);
  });

  group('requestNewToken', () {
    final Map<String, dynamic> validResponse = {
      'access_token': 'valid_access_token',
      'refresh_token': 'valid_refresh_token',
      'expires_in': 3600,
    };

    test('Returns Right(Unit) when authentication succeeds', () async {
      when(() => mockDatasource.authenticate()).thenAnswer((_) async => validResponse);
      when(() => mockSecureStorage.save('intra_access_token', 'valid_access_token'))
          .thenAnswer((_) async {});
      when(() => mockSecureStorage.save('intra_refresh_token', 'valid_refresh_token'))
          .thenAnswer((_) async {});
      when(() => mockSecureStorage.save(any(), any())).thenAnswer((_) async {});

      final result = await repository.requestNewToken();

      expect(result, equals(Right(unit)));
      verify(() => mockDatasource.authenticate()).called(1);
      verify(() => mockSecureStorage.save('intra_access_token', 'valid_access_token')).called(1);
      verify(() => mockSecureStorage.save('intra_refresh_token', 'valid_refresh_token')).called(1);
      verify(() => mockSecureStorage.save(any(), any())).called(1);
    });

    test('Returns a Failure when the datasource throws an error', () async {
      when(() => mockDatasource.authenticate()).thenThrow(Exception('Authentication failed'));

      final result = await repository.requestNewToken();

      expect(result, isA<Left>());
      expect((result as Left).value, isA<IntraLoginFailure>());
      verify(() => mockDatasource.authenticate()).called(1);
    });
  });

  group('refreshToken', () {
    final validRefreshToken = {
      'access_token': 'new_access_token',
      'refresh_token': 'new_refresh_token',
      'expires_in': 3600,
    };

    test('Returns Right(Unit) when refresh token succeeed', () async {
      when(
        () => mockDatasource.refreshToken('valid_refresh_token'),
      ).thenAnswer((_) async => validRefreshToken);
      when(() => mockSecureStorage.save(any(), any())).thenAnswer((_) async {});

      final result = await repository.refreshToken('valid_refresh_token');

      expect(result, equals(Right(unit)));
      verify(() => mockDatasource.refreshToken('valid_refresh_token')).called(1);
      verify(() => mockSecureStorage.save('intra_access_token', 'new_access_token')).called(1);
      verify(() => mockSecureStorage.save('intra_refresh_token', 'new_refresh_token')).called(1);
    });

    test('Returns a Failure when the datasource throws an error', () async {
      when(
        () => mockDatasource.refreshToken('invalid_refresh_token'),
      ).thenThrow(Exception('Refresh failed'));

      final result = await repository.refreshToken('invalid_refresh_token');

      expect(result, isA<Left>());
      expect((result as Left).value, isA<IntraLoginFailure>());
      verify(() => mockDatasource.refreshToken('invalid_refresh_token')).called(1);
    });

    test('Returns a Failure when response is incomplete or invalid', () async {
      when(() => mockDatasource.refreshToken('valid_refresh_token')).thenAnswer((_) async => {});

      final result = await repository.refreshToken('valid_refresh_token');

      expect(result, isA<Left>());
      expect((result as Left).value, isA<IntraLoginFailure>());
      verify(() => mockDatasource.refreshToken('valid_refresh_token')).called(1);
    });
  });

  group('grantToken', () {
    test('Returns Right(Unit) when token is valid and not expired', () async {
      when(
        () => mockSecureStorage.read('intra_access_token'),
      ).thenAnswer((_) async => 'valid_access_token');
      when(
        () => mockSecureStorage.read('intra_token_expiration'),
      ).thenAnswer((_) async => DateTime.now().add(Duration(hours: 1)).toIso8601String());

      final result = await repository.grantToken();

      expect(result, Right(unit));
      verify(() => mockSecureStorage.read('intra_access_token')).called(1);
      verify(() => mockSecureStorage.read('intra_token_expiration')).called(1);
    });

    test('Returns Failure when no access token is found', () async {
      when(() => mockSecureStorage.read('intra_access_token')).thenAnswer((_) async => null);

      final result = await repository.grantToken();

      expect(result, isA<Left>());
      expect((result as Left).value, isA<IntraLoginFailure>());
      verify(() => mockSecureStorage.read('intra_access_token')).called(1);
    });

    test('Returns Failure when token is expired and refresh fails', () async {
      when(
        () => mockSecureStorage.read('intra_access_token'),
      ).thenAnswer((_) async => 'valid_access_token');
      when(
        () => mockSecureStorage.read('intra_token_expiration'),
      ).thenAnswer((_) async => DateTime.now().subtract(Duration(hours: 1)).toIso8601String());
      when(() => mockSecureStorage.read('intra_refresh_token')).thenAnswer((_) async => null);
      when(() => mockDatasource.refreshToken('valid_refresh_token'))
          .thenThrow(Exception('Failed to refresh token'));
      
      final result = await repository.grantToken();
      
      expect(result, isA<Left>());
      expect((result as Left).value, isA<IntraLoginFailure>());
      verify(() => mockSecureStorage.read('intra_access_token')).called(1);
      verify(() => mockSecureStorage.read('intra_token_expiration')).called(1);
      verify(() => mockSecureStorage.read('intra_refresh_token')).called(1);
    });

    test('Returns Right(Unit) when token is expired but refresh succeeds', () async {
      when(() => mockSecureStorage.read('intra_access_token'))
          .thenAnswer((_) async => 'expired_token');
      when(() => mockSecureStorage.read('intra_token_expiration'))
          .thenAnswer((_) async => DateTime.now().subtract(Duration(hours: 1)).toIso8601String());
      when(() => mockSecureStorage.read('intra_refresh_token'))
          .thenAnswer((_) async => 'valid_refresh_token');
      when(() => mockDatasource.refreshToken('valid_refresh_token'))
          .thenAnswer((_) async => {'access_token': 'new_access_token', 'refresh_token': 'new_refresh_token', 'expires_in': 3600});
      when(() => mockSecureStorage.save(any(), any())).thenAnswer((_) async {});

      final result = await repository.grantToken();

      expect(result, equals(Right(unit)));
      verify(() => mockSecureStorage.read('intra_access_token')).called(1);
      verify(() => mockSecureStorage.read('intra_token_expiration')).called(1);
      verify(() => mockSecureStorage.read('intra_refresh_token')).called(1);
      verify(() => mockDatasource.refreshToken('valid_refresh_token')).called(1);
      verify(() => mockSecureStorage.save('intra_access_token', 'new_access_token')).called(1);
      verify(() => mockSecureStorage.save('intra_refresh_token', 'new_refresh_token')).called(1);
      verify(() => mockSecureStorage.save('intra_token_expiration', any())).called(1);
    });
  });
}

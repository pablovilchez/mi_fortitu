import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mi_fortitu/core/errors/exceptions.dart';
import 'package:mi_fortitu/core/helpers/secure_storage_helper.dart';
import 'package:mi_fortitu/core/services/intra_api_service.dart';
import 'package:mi_fortitu/features/auth/data/datasources/auth_intra_datasource.dart';
import 'package:mi_fortitu/features/auth/data/exceptions.dart';
import 'package:mi_fortitu/features/auth/data/repositories/repositories.dart';
import 'package:mi_fortitu/features/auth/domain/failures.dart';
import 'package:mi_fortitu/features/auth/domain/repositories/auth_intra_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockIntraAuthDatasource extends Mock implements AuthIntraDatasource {}

class MockSecureStorageHelper extends Mock implements SecureStorageHelper {}

class MockIntraApiService extends Mock implements IntraApiService {}

void main() {
  late AuthIntraRepository repository;
  late MockIntraAuthDatasource mockDatasource;
  late MockIntraApiService mockApiService;

  setUp(() {
    mockDatasource = MockIntraAuthDatasource();
    mockApiService = MockIntraApiService();
    repository = AuthIntraRepositoryImpl(mockDatasource, mockApiService);
  });

  group('RequestNewToken', () {
    final Map<String, dynamic> validResponse = {
      'access_token': 'valid_access_token',
      'refresh_token': 'valid_refresh_token',
      'expires_in': 3600,
    };

    test('returns Right(Unit) when authentication succeeds', () async {
      when(() => mockDatasource.requestNewTokens()).thenAnswer((_) async => Right(validResponse));
      when(() => mockApiService.saveTokens(validResponse)).thenAnswer((_) async => Right(unit));

      final result = await repository.requestToken();

      expect(result, equals(Right(unit)));
      verify(() => mockDatasource.requestNewTokens()).called(1);
      verify(() => mockApiService.saveTokens(validResponse)).called(1);
    });

    group('RequestNewToken errors', () {
      test('returns a Failure when the datasource throws an error', () async {
        when(
          () => mockDatasource.requestNewTokens(),
        ).thenAnswer((_) async => Left(AuthException()));

        final result = await repository.requestToken();

        expect(result, isA<Left>());
        expect((result as Left).value, isA<IntraLoginFailure>());
        verify(() => mockDatasource.requestNewTokens()).called(1);
      });

      test('returns a Failure when saving tokens fails', () async {
        when(() => mockDatasource.requestNewTokens()).thenAnswer((_) async => Right(validResponse));
        when(
          () => mockApiService.saveTokens(validResponse)).thenAnswer((_) async => Left(SaveTokenException()));

        final result = await repository.requestToken();

        expect(result, isA<Left>());
        expect((result as Left).value, isA<IntraLoginFailure>());
        verify(() => mockDatasource.requestNewTokens()).called(1);
        verify(() => mockApiService.saveTokens(validResponse)).called(1);
      });
    });
  });
}

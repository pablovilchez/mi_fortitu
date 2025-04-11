import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mi_fortitu/features/auth/data/datasources/auth_supa_datasource.dart';
import 'package:mi_fortitu/features/auth/data/exceptions.dart';
import 'package:mi_fortitu/features/auth/data/repositories/auth_db_repository_impl.dart';
import 'package:mi_fortitu/features/auth/domain/entities/db_login_entity.dart';
import 'package:mi_fortitu/features/auth/domain/failures.dart';
import 'package:mi_fortitu/features/auth/data/models/db_login_model.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthSupaDatasource extends Mock implements AuthSupaDatasource {}

void main() {
  late MockAuthSupaDatasource mockDatasource;
  late AuthDbRepositoryImpl repository;

  setUp(() {
    mockDatasource = MockAuthSupaDatasource();
    repository = AuthDbRepositoryImpl(mockDatasource);
  });

  group('AuthDbRepositoryImpl', () {
    final loginModel = DbLoginModel(id: '123', email: 'email@example.com');
    var loginEntity = DbLoginEntity(id: '123', email: 'email@example.com');

    test('login returns Right(DbLoginEntity) on success', () async {
      when(() => mockDatasource.login('test@email.com', '1234'))
          .thenAnswer((_) async => Right(loginModel));

      final result = await repository.login('test@email.com', '1234');

      expect(result, Right(loginEntity));
    });

    test('login returns Left(AuthFailure) on failure', () async {
      when(() => mockDatasource.login(any(), any())).thenAnswer(
            (_) async => Left(LoginException(code: 'E001', message: 'error')),
      );

      final result = await repository.login('email', 'pass');

      expect(result.isLeft(), isTrue);
      expect(result.swap().getOrElse(() => throw Exception()), isA<AuthFailure>());
    });

    test('register returns Right(DbLoginEntity) on success', () async {
      when(() => mockDatasource.register('new@email.com', 'pass'))
          .thenAnswer((_) async => Right(loginModel));

      final result = await repository.register('new@email.com', 'pass');

      expect(result, Right(loginEntity));
    });

    test('register returns Left(AuthFailure) on failure', () async {
      when(() => mockDatasource.register(any(), any())).thenAnswer(
            (_) async => Left(RegisterException(code: 'E001', message: 'fail')),
      );

      final result = await repository.register('email', 'pass');

      expect(result.isLeft(), isTrue);
      expect(result.swap().getOrElse(() => throw Exception()), isA<AuthFailure>());
    });

    test('addProfile returns Right(unit) when successful', () async {
      when(() => mockDatasource.addProfile()).thenAnswer((_) async => Right(unit));

      final result = await repository.addProfile();

      expect(result, Right(unit));
    });

    test('addProfile returns Left(DatabaseFailure) on exception', () async {
      when(() => mockDatasource.addProfile()).thenThrow(Exception('DB error'));

      final result = await repository.addProfile();

      expect(result.isLeft(), isTrue);
      expect(result.swap().getOrElse(() => throw Exception()), isA<DatabaseFailure>());
    });

    test('checkDbUserAuth returns Right(unit) when successful', () async {
      when(() => mockDatasource.checkDbUserAuth()).thenAnswer((_) async => Right(unit));

      final result = await repository.checkToken();

      expect(result, Right(unit));
    });

    test('checkDbUserAuth returns Left(AuthFailure) on error', () async {
      when(() => mockDatasource.checkDbUserAuth()).thenAnswer(
            (_) async => Left(AuthException(code: 'E002', message: 'not logged')),
      );

      final result = await repository.checkToken();

      expect(result.isLeft(), isTrue);
      expect(result.swap().getOrElse(() => throw Exception()), isA<AuthFailure>());
    });

    test('getRole returns Right(role) when found', () async {
      when(() => mockDatasource.getRole()).thenAnswer((_) async => Right('admin'));

      final result = await repository.getRole();

      expect(result, Right('admin'));
    });

    test('getRole returns Left(DatabaseFailure) on error', () async {
      when(() => mockDatasource.getRole()).thenAnswer(
            (_) async => Left(DatabaseException(code: 'E003', message: 'not found')),
      );

      final result = await repository.getRole();

      expect(result.isLeft(), isTrue);
      expect(result.swap().getOrElse(() => throw Exception()), isA<DatabaseFailure>());
    });
  });
}

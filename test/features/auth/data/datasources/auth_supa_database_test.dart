import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mi_fortitu/features/auth/data/datasources/auth_supa_datasource.dart';
import 'package:mi_fortitu/features/auth/data/exceptions.dart' as exceptions;
import 'package:mi_fortitu/features/auth/data/models/db_login_model.dart';
import 'package:mocktail/mocktail.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MockSupabaseClient extends Mock implements SupabaseClient {}

class MockGoTrueClient extends Mock implements GoTrueClient {}

class MockUser extends Mock implements User {}

class MockPostgrestClient extends Mock implements PostgrestClient {}

void main() {
  late MockSupabaseClient mockSupabaseClient;
  late MockGoTrueClient mockAuth;
  late MockPostgrestClient mockDb;
  late AuthSupaDatasource datasource;

  setUp(() {
    mockSupabaseClient = MockSupabaseClient();
    mockAuth = MockGoTrueClient();
    mockDb = MockPostgrestClient();
    when(() => mockSupabaseClient.auth).thenReturn(mockAuth);
    when(() => mockSupabaseClient.from(any())).thenReturn(mockDb);
    datasource = AuthSupaDatasource(mockSupabaseClient);
  });

  group('AuthSupaDatasource', () {
    const testEmail = 'test@example.com';
    const testPassword = '1234';
    final mockUser = MockUser();
    final authResponse = AuthResponse(session: null, user: mockUser);

    test('login returns DbLoginModel on success', () async {
      when(() => mockAuth.signInWithPassword(email: testEmail, password: testPassword))
          .thenAnswer((_) async => authResponse);
      when(() => mockUser.id).thenReturn('123');
      when(() => mockUser.email).thenReturn(testEmail);

      final result = await datasource.login(testEmail, testPassword);

      expect(result.isRight(), isTrue);
      expect(result.getOrElse(() => throw Exception()), isA<DbLoginModel>());
    });

    test('login returns LoginException on error', () async {
      when(() => mockAuth.signInWithPassword(email: testEmail, password: testPassword))
          .thenThrow(Exception('invalid'));

      final result = await datasource.login(testEmail, testPassword);

      expect(result.isLeft(), isTrue);
      expect(result.swap().getOrElse(() => throw Exception()), isA<LoginException>());
    });

    test('register returns DbLoginModel on success', () async {
      when(() => mockAuth.signUp(email: testEmail, password: testPassword))
          .thenAnswer((_) async => authResponse);
      when(() => mockUser.id).thenReturn('123');
      when(() => mockUser.email).thenReturn(testEmail);

      final result = await datasource.register(testEmail, testPassword);

      expect(result.isRight(), isTrue);
      expect(result.getOrElse(() => throw Exception()), isA<DbLoginModel>());
    });

    test('register returns RegisterException on error', () async {
      when(() => mockAuth.signUp(email: testEmail, password: testPassword))
          .thenThrow(Exception('fail'));

      final result = await datasource.register(testEmail, testPassword);

      expect(result.isLeft(), isTrue);
      expect(result.swap().getOrElse(() => throw Exception()), isA<RegisterException>());
    });

    test('addProfile returns unit on success', () async {
      when(() => mockSupabaseClient.auth.currentUser).thenReturn(mockUser);
      when(() => mockUser.id).thenReturn('123');
      when(() => mockUser.email).thenReturn(testEmail);
      when(() => mockDb.  upsert(any())).thenAnswer((_) async => []);

      final result = await datasource.addProfile();

      expect(result, Right(unit));
    });

    test('addProfile returns DatabaseException on error', () async {
      when(() => mockSupabaseClient.auth.currentUser).thenReturn(mockUser);
      when(() => mockUser.id).thenReturn('123');
      when(() => mockUser.email).thenReturn(testEmail);
      when(() => mockDb.upsert(any())).thenThrow(Exception('insert error'));

      final result = await datasource.addProfile();

      expect(result.isLeft(), isTrue);
      expect(result.swap().getOrElse(() => throw Exception()), isA<DatabaseException>());
    });

    test('checkDbUserAuth returns Right(unit) when session exists', () async {
      when(() => mockSupabaseClient.auth.currentSession).thenReturn(Session(
        accessToken: 'token',
        tokenType: 'bearer',
        user: mockUser,
        refreshToken: 'refresh',
        providerToken: null,
        expiresIn: 3600,
      ));

      final result = await datasource.checkDbUserAuth();

      expect(result, Right(unit));
    });

    test('checkDbUserAuth returns AuthException when session is null', () async {
      when(() => mockSupabaseClient.auth.currentSession).thenReturn(null);

      final result = await datasource.checkDbUserAuth();

      expect(result.isLeft(), isTrue);
      expect(result.swap().getOrElse(() => throw Exception()), isA<AuthException>());
    });

    test('getRole returns role on success', () async {
      when(() => mockDb.select()).thenAnswer((_) async => [{'role': 'admin'}]);

      final result = await datasource.getRole();

      expect(result, Right('admin'));
    });

    test('getRole returns DatabaseException on error', () async {
      when(() => mockDb.select()).thenThrow(Exception('query error'));

      final result = await datasource.getRole();

      expect(result.isLeft(), isTrue);
      expect(result.swap().getOrElse(() => throw Exception()), isA<DatabaseException>());
    });
  });
}

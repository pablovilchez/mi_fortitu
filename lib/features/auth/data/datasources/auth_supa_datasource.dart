import 'package:dartz/dartz.dart';
import 'package:mi_fortitu/features/auth/data/exceptions.dart' as exceptions;
import 'package:mi_fortitu/features/auth/data/models/db_login_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthSupaDatasource {
  final SupabaseClient _supabase;

  AuthSupaDatasource(this._supabase);

  Future<Either<exceptions.AuthException, DbLoginModel>> login(
    String email,
    String password,
  ) async {
    try {
      final response = await _supabase.auth.signInWithPassword(email: email, password: password);
      return Right(DbLoginModel.fromAuthResponse(response));
    } catch (e) {
      return Left(exceptions.DbLoginException(message: e.toString()));
    }
  }

  Future<Either<exceptions.AuthException, DbLoginModel>> register(
    String email,
    String password,
  ) async {
    try {
      final response = await _supabase.auth.signUp(email: email, password: password);
      return Right(DbLoginModel.fromAuthResponse(response));
    } catch (e) {
      return Left(exceptions.DbRegisterException(message: e.toString()));
    }
  }

  Future<Either<exceptions.AuthException, Unit>> checkAuth() async {
    try {
      final session = _supabase.auth.currentSession;
      if (session == null) {
        return Left(exceptions.DbCheckException(code: '01'));
      }
      return Right(unit);
    } catch (e) {
      return Left(exceptions.DbCheckException(code: '02', message: e.toString()));
    }
  }

  Future<Either<exceptions.AuthException, String>> getRole() async {
    try {
      final response = await _supabase.from('profiles').select();
      return Right(response.first['role']);
    } catch (e) {
      return Left(exceptions.DbDataException(code: '01', message: e.toString()));
    }
  }

  Future<Either<exceptions.AuthException, String>> addProfile() async {
    final defaultRole = 'waitlist';
    try {
      await _supabase.from('profiles').insert({
        'user_id': _supabase.auth.currentUser!.id,
        'intra_login': _supabase.auth.currentUser!.email,
        'role': defaultRole,
      });
      return Right(defaultRole);
    } catch (e) {
      return Left(exceptions.DbDataException(code: '02', message: e.toString()));
    }
  }
}

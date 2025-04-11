import 'package:dartz/dartz.dart';
import 'package:mi_fortitu/features/auth/data/exceptions.dart' as exceptions;
import 'package:mi_fortitu/features/auth/data/models/db_login_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthSupaDatasource {
  final SupabaseClient _supabase;

  AuthSupaDatasource(this._supabase);

  Future<Either<exceptions.AuthException, DbLoginModel>> login(String email, String password) async {
    try {
      final response = await _supabase.auth.signInWithPassword(email: email, password: password);
      return Right(DbLoginModel.fromAuthResponse(response));
    } catch (e) {
      return Left(exceptions.LoginException(code: 'E001', message: 'Invalid credentials'));
    }
  }

  Future<Either<exceptions.AuthException, DbLoginModel>> register(String email, String password) async {
    try {
      final response = await _supabase.auth.signUp(email: email, password: password);
      return Right(DbLoginModel.fromAuthResponse(response));
    } catch (e) {
      return Left(exceptions.RegisterException(code: 'E001', message: 'Registration failed'));
    }
  }

  Future<Either<exceptions.AuthException, Unit>> checkDbUserAuth() async {
    try {
      final session = _supabase.auth.currentSession;
      if (session == null) {
        return Left(exceptions.AuthException(code: 'E001', message: 'User not authenticated'));
      }
      return Right(unit);
    } catch (e) {
      return Left(exceptions.AuthException(code: 'E001', message: e.toString()));
    }
  }

  Future<Either<exceptions.AuthException, String>> getRole() async {
    try {
      final response = await _supabase.from('profiles').select();
      return Right(response.first['role']);
    } catch (e) {
      return Left(exceptions.DatabaseException(code: 'E001', message: e.toString()));
    }
  }

  Future<Either<exceptions.AuthException, String>> addProfile() async {
    final defaultRole = 'waitlist';
    try {
      final userId = _supabase.auth.currentUser!.id;
      final login = _supabase.auth.currentUser!.email;
      await _supabase.from('profiles').insert({
        'user_id': _supabase.auth.currentUser!.id,
        'intra_login': _supabase.auth.currentUser!.email,
        'role': defaultRole,
      });
      return Right(defaultRole);
    } catch (e) {
      return Left(exceptions.DatabaseException(code: 'E001', message: e.toString()));
    }
  }
}

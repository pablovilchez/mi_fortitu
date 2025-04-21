import 'package:dartz/dartz.dart';
import 'package:mi_fortitu/features/access/data/access_exception.dart';
import 'package:mi_fortitu/features/access/data/models/login_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AccessDatasource {
  final SupabaseClient _supabase;

  AccessDatasource(this._supabase);

  Future<Either<AccessException, LoginModel>> login(
    String email,
    String password,
  ) async {
    try {
      final response = await _supabase.auth.signInWithPassword(email: email, password: password);
      return Right(LoginModel.fromAuthResponse(response));
    } catch (e) {
      return Left(DbException(code: 'AD01', details: e.toString()));
    }
  }

  Future<Either<AccessException, LoginModel>> register(
    String email,
    String password,
  ) async {
    try {
      final response = await _supabase.auth.signUp(email: email, password: password);
      return Right(LoginModel.fromAuthResponse(response));
    } catch (e) {
      return Left(DbException(code: 'AD02', details: e.toString()));
    }
  }

  Future<Either<AccessException, Unit>> checkAuth() async {
    try {
      final session = _supabase.auth.currentSession;
      if (session == null) {
        return Left(DbException(code: 'AD03'));
      }
      return Right(unit);
    } catch (e) {
      return Left(DbException(code: 'AD04', details: e.toString()));
    }
  }

  Future<Either<AccessException, String>> getRole() async {
    try {
      final response = await _supabase.from('profiles').select();
      return Right(response.first['role']);
    } catch (e) {
      return Left(DbException(code: 'AD05', details: e.toString()));
    }
  }

  Future<Either<AccessException, String>> addProfile() async {
    final defaultRole = 'waitlist';
    try {
      await _supabase.from('profiles').insert({
        'user_id': _supabase.auth.currentUser!.id,
        'intra_login': _supabase.auth.currentUser!.email,
        'role': defaultRole,
      });
      return Right(defaultRole);
    } catch (e) {
      return Left(DbException(code: 'AD06', details: e.toString()));
    }
  }
}

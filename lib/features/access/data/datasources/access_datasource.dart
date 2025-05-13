import 'package:dartz/dartz.dart';
import 'package:mi_fortitu/features/access/data/access_exception.dart';
import 'package:mi_fortitu/features/access/data/models/login_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Datasource class for handling authentication and user profile operations
/// using Supabase as the backend service.
///
/// This class provides methods for logging in, registering, recover password,
/// checking authentication, retrieving user roles, and adding user profiles.
class AccessDatasource {
  final SupabaseClient _supabase;

  AccessDatasource(this._supabase);

  /// Logs in a user with the provided email and password.
  ///
  /// Returns a [Either] containing either an [AccessException] or a [LoginModel].
  Future<Either<AccessException, LoginModel>> login(String email, String password) async {
    try {
      final response = await _supabase.auth.signInWithPassword(email: email, password: password);
      return Right(LoginModel.fromAuthResponse(response));
    } catch (e) {
      return Left(DbException(code: 'AD01', details: e.toString()));
    }
  }

  /// Registers a new user with the provided email and password.
  ///
  /// Returns a [Either] containing either an [AccessException] or a [LoginModel].
  Future<Either<AccessException, LoginModel>> register(String email, String password) async {
    try {
      final response = await _supabase.auth.signUp(email: email, password: password);
      return Right(LoginModel.fromAuthResponse(response));
    } catch (e) {
      return Left(DbException(code: 'AD02', details: e.toString()));
    }
  }

  /// Recovers the password for the user with the provided email.
  ///
  /// Returns a [Either] containing either an [AccessException] or a [Unit].
  Future<Either<AccessException, Unit>> requestAccountRecoveryEmail(String email) async {
    try {
      await _supabase.auth.resetPasswordForEmail(
        email,
        redirectTo: 'io.supabase.flutterquickstart://reset-password/',
      );
      return const Right(unit);
    } catch (e) {
      return Left(DbException(code: 'AD03', details: e.toString()));
    }
  }

  /// Sets a new password for the user.
  ///
  /// Returns a [Either] containing either an [AccessException] or a [Unit].
  Future<Either<AccessException, Unit>> setNewPassword(String newPassword) async {
    try {
      await _supabase.auth.updateUser(UserAttributes(password: newPassword));
      return const Right(unit);
    } catch (e) {
      return Left(DbException(code: 'AD03', details: e.toString()));
    }
  }

  /// Changes the password of the currently authenticated user.
  ///
  /// Returns a [Either] containing either an [AccessException] or a [Unit].
  Future<Either<AccessException, Unit>> checkAuth() async {
    try {
      final session = _supabase.auth.currentSession;
      if (session == null) {
        return Left(DbException(code: 'AD03'));
      }
      if (session.expiresAt != null &&
          DateTime.fromMillisecondsSinceEpoch(session.expiresAt! * 1000).isBefore(DateTime.now())) {
        final refreshResponse = await _supabase.auth.refreshSession();
        if (refreshResponse.session == null) {
          return Left(DbException(code: 'AD04', details: 'Session expired and refresh failed'));
        }
      }
      return const Right(unit);
    } catch (e) {
      return Left(DbException(code: 'AD04', details: e.toString()));
    }
  }

  /// Retrieves the role of the currently authenticated user.
  ///
  /// Returns a [Either] containing either an [AccessException] or a [String].
  Future<Either<AccessException, String>> getRole() async {
    try {
      final response = await _supabase.from('profiles').select();
      return Right(response.first['role']);
    } catch (e) {
      return Left(DbException(code: 'AD05', details: e.toString()));
    }
  }

  /// Adds a new profile for the currently authenticated user.
  ///
  /// Returns a [Either] containing either an [AccessException] or a [String].
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

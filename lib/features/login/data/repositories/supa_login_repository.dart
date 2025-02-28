import 'package:dartz/dartz.dart';
import 'package:mi_fortitu/features/login/data/models/supa_login_model.dart';
import 'package:mi_fortitu/features/login/domain/failures.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// A repository for handling Supabase app account authentication.
///
/// This repository is used to handle the authentication of Supabase app accounts.
/// It provides methods for signing in, registering, and adding a user to the
/// Supabase profile table.
class SupaLoginRepository {
  final SupabaseClient _supabase = Supabase.instance.client;

  /// Attempts to sign in with a Supabase app account.
  ///
  /// Returns a [Future] that completes with an [Either]:
  ///
  /// * [Failure] if an error occurs.
  /// * [SupaLoginModel] if successful.
  Future<Either<Failure, SupaLoginModel>> login(
    String email,
    String password,
  ) async {
    try {
      final response = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      if (response.user == null) {
        throw Exception('Cannot identify user');
      }
      return Right(SupaLoginModel.fromAuthResponse(response));
    } catch (e) {
      return Left(AuthFailure(e.toString()));
    }
  }

  /// Attempts to register a new Supabase app account.
  ///
  /// Returns a [Future] that completes with an [Either]:
  ///
  /// * [Failure] if an error occurs.
  /// * [SupaLoginModel] if successful.
  Future<Either<Failure, SupaLoginModel>> register(
    String email,
    String password,
  ) async {
    try {
      final response = await _supabase.auth.signUp(
        email: email,
        password: password,
      );
      if (response.user == null) {
        throw Exception('Cannot register user');
      }
      return Right(SupaLoginModel.fromAuthResponse(response));
    } catch (e) {
      return Left(RegisterFailure(e.toString()));
    }
  }

  /// Attempts to add a user to the Supabase profile table.
  ///
  /// Returns a [Future] that completes with an [Either]:
  ///
  /// * [Failure] if an error occurs.
  /// * [Unit] if successful.
  Future<Either<Failure, Unit>> addProfile() async {
    try {
      await _supabase.from('profiles').upsert({
        'user_id': _supabase.auth.currentUser!.id,
        'intra_login': _supabase.auth.currentUser!.email,
        'role': 'waitlist',
      });
      return Right(unit);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  /// Attempts to check if the user is authenticated.
  ///
  /// Returns a [Future] that completes with an [Either]:
  ///
  /// * [Failure] if an error occurs.
  /// * [Unit] if successful.
  Future<Either<Failure, Unit>> checkProfileCredentials() async {
    try {
      final session = _supabase.auth.currentSession;
      if (session == null) {
        throw Exception('User not authenticated');
      }

      await _supabase.auth.refreshSession();
      final user = _supabase.auth.currentUser;
      if (user == null) {
        throw Exception('Cannot identify user');
      }

      return Right(unit);
    } catch (e) {
      return Left(NoCredentialsFailure(e.toString()));
    }
  }

  /// Attempts to get the role of the current user.
  ///
  /// Returns a [Future] that completes with an [Either]:
  ///
  /// * [Failure] if an error occurs.
  /// * [String] if successful.
  Future<Either<Failure, String>> getRole() async {
    try {
      final response = await _supabase.from('profiles').select();
      if (response.isEmpty) {
        final addProfileAction = await addProfile();
        if (addProfileAction.isLeft()) {
          throw Exception('Cannot add profile');
        }
        return Right('waitlist');
      }
      return Right(response.first['role'] as String);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }
}

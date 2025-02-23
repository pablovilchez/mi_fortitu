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
      return Left(AuthFailure(e.toString()));
    }
  }

  /// Attempts to add a user to the Supabase profile table.
  ///
  /// Returns a [Future] that completes with an [Either]:
  ///
  /// * [Failure] if an error occurs.
  /// * [Unit] if successful.
  Future<Either<Failure, Unit>> addProfile(
    String userId,
    String intraLogin, {
    String role = 'waitlist',
  }) async {
    try {
      final response = await _supabase.from('profiles').upsert({
        'user_id': userId,
        'intra_login': intraLogin,
        'role': role,
      });
      if (response.error != null) {
        throw Exception('Cannot add profile');
      }
      return Right(unit);
    } catch (e) {
      return Left(AuthFailure(e.toString()));
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
      final response = await _supabase.from('profiles').select().single();
      if (response.isEmpty) {
        throw Exception('User not found');
      }
      return Right(response['role'] as String);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }
}

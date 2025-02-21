import 'package:mi_fortitu/features/auth/data/models/auth_user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseAuthDatasourceImpl {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<AuthUserModel> login(String email, String password) async {
    try {
      final response = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      if (response.user == null) {
        throw Exception('Cannot identify user');
      }
      return AuthUserModel(
        id: response.user!.id,
        email: response.user!.email ?? '',
        accessToken: response.session!.accessToken,
        refreshToken: response.session!.refreshToken ?? '',
      );
    } catch (e) {
      throw Exception('Authentication error: $e');
    }
  }

  Future<AuthUserModel> checkAuth() async {
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

      return AuthUserModel(
        id: user.id,
        email: user.email ?? '',
        accessToken: session.accessToken,
        refreshToken: session.refreshToken ?? '',
      );
    } catch (e) {
      throw Exception('Error checking authentication: $e');
    }
  }

  Future<AuthUserModel> register(String email, String password) async {
    try {
      final response = await _supabase.auth.signUp(
        email: email,
        password: password,
      );
      return AuthUserModel(
        id: response.user!.id,
        email: response.user!.email ?? '',
        accessToken: response.session!.accessToken,
        refreshToken: response.session!.refreshToken ?? '',
      );
    } catch (e) {
      throw Exception('Error registering user: $e');
    }
  }

  Future<void> logout() async {
    try {
      await _supabase.auth.signOut();
    } catch (e) {
      throw Exception('Logout error: $e');
    }
  }

  Future<void> addToUsersTable(String id, String intraLogin) async {
    try {
      await _supabase.from('profiles').upsert({
        'user_id': id,
        'intra_login': intraLogin,
      });
    } catch (e) {
      throw Exception('Error adding user to users table: $e');
    }
  }

  Future<bool> checkApproval() async {
    try {
      final response =
          await _supabase.from('profiles').select().single();
      return response['is_approved'] as bool;
    } catch (e) {
      throw Exception('Error checking approval: $e');
    }
  }
}

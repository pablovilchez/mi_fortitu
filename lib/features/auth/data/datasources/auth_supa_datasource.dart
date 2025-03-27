import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:mi_fortitu/core/errors/exceptions.dart';

class AuthSupaDatasource {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<AuthResponse> login(String email, String password) async {
    return await _supabase.auth.signInWithPassword(email: email, password: password);
  }

  Future<AuthResponse> register(String email, String password) async {
    return await _supabase.auth.signUp(email: email, password: password);
  }

  Future<void> addProfile() async {
    await _supabase.from('profiles').upsert({
      'user_id': _supabase.auth.currentUser!.id,
      'intra_login': _supabase.auth.currentUser!.email,
      'role': 'waitlist',
    });
  }

  Future<void> checkProfileCredentials() async {
    final session = _supabase.auth.currentSession;
    if (session == null) {
      throw Exception('No session found');
    }
  }

  Future<String> getRole() async {
    final response = await _supabase.from('profiles').select();
    if (response.isEmpty) {
      throw DataException('No user data found');
    }
    return response.first['role'];
  }
}

import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRemoteDatasource {
  final SupabaseClient _supabase;

  AuthRemoteDatasource(this._supabase);

  Future<AuthResponse> registerUser(String email, String password) async {
    final response = await _supabase.auth.signUp(
      email: email,
      password: password,
    );
    print('registerUser response:'); // DEBUG
    print(response); // DEBUG
    return response;
  }

  Future<AuthResponse> loginUser(String email, String password) async {
    final response = await _supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
    print('loginUser response:'); // DEBUG
    print(response); // DEBUG
    return response;
  }

  Future<User?> getCurrentUser() async {
    print('getCurrentUser response:'); // DEBUG
    print(_supabase.auth.currentUser); // DEBUG
    return _supabase.auth.currentUser;
  }

  Future<void> isUserApproved(String userId) async {
    final response =
        await Supabase.instance.client
            .from('users')
            .select('is_approved')
            .eq('id', userId)
            .single();

    print (response); // DEBUG
  }
}

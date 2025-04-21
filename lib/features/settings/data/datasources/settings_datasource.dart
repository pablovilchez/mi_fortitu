import 'package:supabase_flutter/supabase_flutter.dart';

class SettingsDatasource {
  final SupabaseClient _supabase;

  SettingsDatasource(this._supabase);

  Future<void> logoutSupa() async {
    await _supabase.auth.signOut();
  }
}
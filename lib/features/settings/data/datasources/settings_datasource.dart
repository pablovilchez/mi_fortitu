import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SettingsDatasource {
  final SupabaseClient _supabase;

  SettingsDatasource(this._supabase);

  Future<Either<Exception, Unit>> logoutSupa() async {
    try {
      await _supabase.auth.signOut();
      return Right(unit);
    } catch (e) {
      return Left(Exception('Supabase logout failed: $e'));
    }
  }
}
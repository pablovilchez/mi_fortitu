import 'package:mi_fortitu/features/auth/domain/entities/supa_login.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// A model representing a user's auth information.
///
/// This model is used to store the user's auth information, such as the user's
/// ID, email, access token, and refresh token.
class SupaLoginModel extends SupaLogin {
  SupaLoginModel({
    super.id,
    super.email,
    super.accessToken,
    super.refreshToken,
  });

  /// Converts an [AuthResponse] to a [SupaLoginModel].
  ///
  /// This is useful when you want to convert the response from Supabase's
  /// authentication methods to a [SupaLoginModel].
  factory SupaLoginModel.fromAuthResponse(AuthResponse response) {
    return SupaLoginModel(
      id: response.user?.id,
      email: response.user?.email,
      accessToken: response.session?.accessToken,
      refreshToken: response.session?.refreshToken,
    );
  }
}

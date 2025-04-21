import 'package:mi_fortitu/features/access/domain/entities/login_entity.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// A model representing a user's auth information.
///
/// This model is used to store the user's auth information, such as the user's
/// ID, email, access token, and refresh token.
class LoginModel extends LoginEntity {
  LoginModel({
    super.id,
    super.email,
    super.accessToken,
    super.refreshToken,
  });

  /// Converts an [AuthResponse] to a [LoginModel].
  ///
  /// This is useful when you want to convert the response from Supabase's
  /// authentication methods to a [LoginModel].
  factory LoginModel.fromAuthResponse(AuthResponse response) {
    return LoginModel(
      id: response.user?.id,
      email: response.user?.email,
      accessToken: response.session?.accessToken,
      refreshToken: response.session?.refreshToken,
    );
  }

  /// Converts a [LoginModel] to an [LoginEntity].
  LoginEntity toEntity() {
    return LoginEntity(
      id: id,
      email: email,
      accessToken: accessToken,
      refreshToken: refreshToken,
    );
  }
}

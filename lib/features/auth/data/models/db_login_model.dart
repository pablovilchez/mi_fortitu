import 'package:mi_fortitu/features/auth/domain/entities/db_login_entity.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// A model representing a user's auth information.
///
/// This model is used to store the user's auth information, such as the user's
/// ID, email, access token, and refresh token.
class DbLoginModel extends DbLoginEntity {
  DbLoginModel({
    super.id,
    super.email,
    super.accessToken,
    super.refreshToken,
  });

  /// Converts an [AuthResponse] to a [DbLoginModel].
  ///
  /// This is useful when you want to convert the response from Supabase's
  /// authentication methods to a [DbLoginModel].
  factory DbLoginModel.fromAuthResponse(AuthResponse response) {
    return DbLoginModel(
      id: response.user?.id,
      email: response.user?.email,
      accessToken: response.session?.accessToken,
      refreshToken: response.session?.refreshToken,
    );
  }

  /// Converts a [DbLoginModel] to an [DbLoginEntity].
  DbLoginEntity toEntity() {
    return DbLoginEntity(
      id: id,
      email: email,
      accessToken: accessToken,
      refreshToken: refreshToken,
    );
  }
}

import 'package:mi_fortitu/features/auth/domain/entities/auth_user.dart';

class AuthUserModel extends AuthUser {
  AuthUserModel({
    required super.id,
    required super.email,
    required super.accessToken,
    required super.refreshToken,
  });
}

/// LoginEntity class represents the user login information retrieved from the database.
class LoginEntity {
  final String? id;
  final String? email;
  final String? accessToken;
  final String? refreshToken;

  LoginEntity({
    this.id,
    this.email,
    this.accessToken,
    this.refreshToken,
  });
}
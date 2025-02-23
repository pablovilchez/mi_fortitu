import 'package:oauth2/oauth2.dart';
import 'package:mi_fortitu/features/login/domain/entities/intra_login.dart';

class IntraLoginModel extends IntraLogin {
  IntraLoginModel({
    required super.token,
    super.refreshToken,
    super.expiryDate,
  });

  factory IntraLoginModel.fromIntraClient(Client client) {
    return IntraLoginModel(
      token: client.credentials.accessToken,
      refreshToken: client.credentials.refreshToken,
      expiryDate: client.credentials.expiration,
    );
  }
}
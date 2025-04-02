import '../../domain/entities/intra_token_info.dart';

class IntraTokenInfoModel extends IntraTokenInfo {
  IntraTokenInfoModel({
    required super.accessToken,
    required super.refreshToken,
    required super.expirationDate,
  });

  factory IntraTokenInfoModel.fromJson(Map<String, dynamic> json) {
    return IntraTokenInfoModel(
      accessToken: json['access_token'],
      refreshToken: json['refresh_token'],
      expirationDate: DateTime.parse(json['expires_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'access_token': accessToken,
      'refresh_token': refreshToken,
      'expires_at': expirationDate.toIso8601String(),
    };
  }
}
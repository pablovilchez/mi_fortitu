import '../../domain/entities/peer_entity.dart';

class PeerModel extends PeerEntity {
  PeerModel({
    required super.loginName,
    required super.photoUrl,
    required super.location,
    required super.isOnline,
  });

  factory PeerModel.fromJson(Map<String, dynamic> user) {
    final image = user['image'] as Map<String, dynamic>?;
    if (image == null) {
      throw const FormatException('Missing "image" field in JSON');
    }
    final versions = image['versions'] as Map<String, dynamic>?;
    if (versions == null) {
      throw const FormatException('Missing "versions" field in JSON');
    }
    return PeerModel(
      loginName: user['login'] ?? 'unknown',
      photoUrl: versions['medium'] ?? 'default',
      location: user['location'] ?? 'disconnected',
      isOnline: user['location'] != null ? true : false,
    );
  }

  PeerEntity toEntity() {
    return PeerEntity(
      loginName: loginName,
      photoUrl: photoUrl,
      location: location,
      isOnline: isOnline,
    );
  }
}

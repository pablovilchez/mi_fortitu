import 'package:mi_fortitu/features/peers/domain/entities/peer_entity.dart';

class ProjectPeersVm {
  final int projectId;
  final String projectName;
  List<PeerEntity> peers;

  ProjectPeersVm({
    required this.projectId,
    required this.projectName,
    required this.peers,
  });
}
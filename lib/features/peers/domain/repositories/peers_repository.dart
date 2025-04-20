import 'package:dartz/dartz.dart';

import '../entities/peer_entity.dart';
import '../peers_failure.dart';

abstract class PeersRepository {
  Future<Either<PeersFailure, List<PeerEntity>>> getProjectUsers(int projectId, int campusId);

}
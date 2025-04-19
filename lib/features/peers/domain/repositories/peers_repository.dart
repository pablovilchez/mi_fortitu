import 'package:dartz/dartz.dart';

import '../../../profiles/domain/entities/project_user_entity.dart';
import '../peers_failure.dart';

abstract class PeersRepository {
  Future<Either<PeersFailure, List<ProjectUserEntity>>> getProjectUsers(String projectId, String campusId);

}
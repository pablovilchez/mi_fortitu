import 'package:dartz/dartz.dart';

import '../../../home/domain/failures.dart';
import '../../../profiles/domain/entities/project_user_entity.dart';

abstract class PeersRepository {
  Future<Either<HomeFailure, List<ProjectUserEntity>>> getProjectUsers(String projectId, String campusId);

}
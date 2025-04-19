import 'package:dartz/dartz.dart';

import '../../../profiles/domain/entities/project_user_entity.dart';
import '../peers_failure.dart';
import '../repositories/peers_repository.dart';

class GetProjectUsersUseCase {
  final PeersRepository _repository;

  GetProjectUsersUseCase(this._repository);

  Future<Either<PeersFailure, List<ProjectUserEntity>>> call(String projectId, String campusId) async {
    return await _repository.getProjectUsers(projectId, campusId);
  }
}

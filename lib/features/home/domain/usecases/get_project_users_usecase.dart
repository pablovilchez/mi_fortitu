import 'package:dartz/dartz.dart';
import 'package:mi_fortitu/features/home/domain/repositories/home_intra_repository.dart';

import '../entities/project_user_entity.dart';
import '../failures.dart';

class GetProjectUsersUseCase {
  final HomeIntraRepository _repository;

  GetProjectUsersUseCase(this._repository);

  Future<Either<HomeFailure, List<ProjectUserEntity>>> call(String projectId, String campusId) async {
    return await _repository.getProjectUsers(projectId, campusId);
  }
}

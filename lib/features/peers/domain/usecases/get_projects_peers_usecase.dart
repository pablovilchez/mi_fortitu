import 'package:dartz/dartz.dart';
import 'package:mi_fortitu/features/peers/presentation/viewmodels/project_peers_viewmodel.dart';

import '../../../profiles/domain/entities/project_user_entity.dart';
import '../../../profiles/domain/entities/user_entity.dart';
import '../peers_failure.dart';
import '../repositories/peers_repository.dart';

class GetProjectsPeersUsecase {
  final PeersRepository _repository;

  GetProjectsPeersUsecase(this._repository);

  Future<Either<PeersFailure, List<ProjectPeersVm>>> call(UserEntity user) async {
    final campusId = user.campus[0].id;
    final openProjects = await _getOpenProjects(user.projectsUsers);

    return openProjects.fold((failure) => Left(failure), (projects) async {
      for (var project in projects) {
        final peers = await _repository.getProjectUsers(project.projectId, campusId);
        if (peers.isLeft()) {
          return Left(peers.swap().getOrElse(() => DataFailure('PVM01')));
        }
        final filteredPeers = peers
            .getOrElse(() => [])
            .where((p) => p.loginName != user.login)
            .toList();

        project.peers = filteredPeers;
      }

      return Right(projects);
    });
  }

  Future<Either<PeersFailure, List<ProjectPeersVm>>> _getOpenProjects(
    List<ProjectUserEntity> userProjects,
  ) async {
    final openProjects = userProjects.where((p) => p.status == 'in_progress' && !p.marked).toList();

    final List<ProjectPeersVm> projectPeersList = openProjects
        .map((project) => ProjectPeersVm(
              projectId: project.project.id,
              projectName: project.project.name,
              peers: [],
            ))
        .toList();

    return Right(projectPeersList);
  }
}

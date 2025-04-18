import 'package:dartz/dartz.dart';
import 'package:mi_fortitu/features/peers/domain/repositories/peers_repository.dart';

import '../../../home/domain/failures.dart';
import '../../../profiles/domain/entities/project_user_entity.dart';
import '../datasources/peers_datasource.dart';

class PeersRepositoryImpl extends PeersRepository {
  final PeersDatasource datasource;

  PeersRepositoryImpl(this.datasource);

  @override
  Future<Either<HomeFailure, List<ProjectUserEntity>>> getProjectUsers(String projectId, String campusId) async {
    final response = await datasource.getProjectUsers(projectId: projectId, campusId: campusId);
    return response.fold(
          (exception) => Left(AuthFailure(exception.toString())),
          (events) => Right(events.map((model) => model.toEntity()).toList()),
    );
  }
}
import 'package:dartz/dartz.dart';
import 'package:mi_fortitu/features/peers/domain/repositories/peers_repository.dart';

import '../../domain/entities/peer_entity.dart';
import '../../domain/peers_failure.dart';
import '../datasources/peers_datasource.dart';

class PeersRepositoryImpl extends PeersRepository {
  final PeersDatasource datasource;

  PeersRepositoryImpl(this.datasource);

  @override
  Future<Either<PeersFailure, List<PeerEntity>>> getProjectUsers(int projectId, int campusId) async {
    final response = await datasource.getProjectUsers(projectId: projectId, campusId: campusId);
    return response.fold(
          (exception) => Left(DataFailure(exception.toString())),
          (events) => Right(events.map((model) => model.toEntity()).toList()),
    );
  }
}
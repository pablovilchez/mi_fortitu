import 'package:dartz/dartz.dart';

import '../../domain/clusters_failure.dart';
import '../../domain/entities/location_entity.dart';
import '../../domain/repositories/clusters_repository.dart';
import '../datasources/clusters_datasource.dart';

class ClustersRepositoryImpl implements ClustersRepository {
  final ClustersDatasource datasource;

  ClustersRepositoryImpl(this.datasource);

  @override
  Future<Either<ClustersFailure, List<LocationEntity>>> getClustersUsers(String campusId) async {
    final response = await datasource.getCampusLocations(campusId: campusId);
    return response.fold(
          (exception) => Left(DataFailure(exception.toString())),
          (events) => Right(events.map((model) => model.toEntity()).toList()),
    );
  }
}
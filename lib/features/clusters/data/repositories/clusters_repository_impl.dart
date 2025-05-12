import 'package:dartz/dartz.dart';

import '../../domain/clusters_failure.dart';
import '../../domain/entities/location_entity.dart';
import '../../domain/repositories/clusters_repository.dart';
import '../datasources/clusters_datasource.dart';

/// ClustersRepositoryImpl is an implementation of the ClustersRepository
/// interface.
/// It is responsible for fetching data related to clusters from the
/// ClustersDatasource.
class ClustersRepositoryImpl implements ClustersRepository {
  final ClustersDatasource datasource;

  ClustersRepositoryImpl(this.datasource);

  /// Fetches the list of clusters users in a specific campus.
  @override
  Future<Either<ClustersFailure, List<LocationEntity>>> getClustersUsers(String campusId) async {
    final response = await datasource.getCampusLocations(campusId: campusId);
    return response.fold(
          (exception) => Left(DataFailure(exception.toString())),
          (events) => Right(events.map((model) => model.toEntity()).toList()),
    );
  }
}
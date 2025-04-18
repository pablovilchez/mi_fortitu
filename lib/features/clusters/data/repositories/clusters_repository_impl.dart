import 'package:dartz/dartz.dart';

import '../../domain/entities/location_entity.dart';
import '../../../home/domain/failures.dart';
import '../../domain/repositories/clusters_repository.dart';
import '../datasources/clusters_datasource.dart';

class ClustersRepositoryImpl implements ClustersRepository {
  final ClustersDatasource datasource;

  ClustersRepositoryImpl(this.datasource);

  @override
  Future<Either<HomeFailure, List<LocationEntity>>> getIntraClusterUsers(String campusId) async {
    final response = await datasource.getCampusLocations(campusId: campusId);
    return response.fold(
          (exception) => Left(AuthFailure(exception.toString())),
          (events) => Right(events.map((model) => model.toEntity()).toList()),
    );
  }
}
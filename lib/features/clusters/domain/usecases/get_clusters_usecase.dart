import 'package:dartz/dartz.dart';

import '../clusters_failure.dart';
import '../entities/location_entity.dart';
import '../repositories/clusters_repository.dart';

class GetClustersUsecase {
  final ClustersRepository _repository;

  GetClustersUsecase(this._repository);

  Future<Either<ClustersFailure, List<LocationEntity>>> call(String campusId) async {
    return await _repository.getClustersUsers(campusId);
  }
}

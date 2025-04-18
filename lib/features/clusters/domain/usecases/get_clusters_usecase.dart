import 'package:dartz/dartz.dart';

import 'package:mi_fortitu/features/home/domain/failures.dart';

import '../entities/location_entity.dart';
import '../repositories/clusters_repository.dart';

class GetClustersUsecase {
  final ClustersRepository _repository;

  GetClustersUsecase(this._repository);

  Future<Either<HomeFailure, List<LocationEntity>>> call(String campusId) async {
    return await _repository.getIntraClusterUsers(campusId);
  }
}

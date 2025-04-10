import 'package:dartz/dartz.dart';

import 'package:mi_fortitu/features/home/domain/failures.dart';

import '../entities/cluster_user_entity.dart';
import '../repositories/home_intra_repository.dart';

class GetClustersUsecase {
  final HomeIntraRepository _repository;

  GetClustersUsecase(this._repository);

  Future<Either<HomeFailure, List<ClusterUserEntity>>> call(String campusId) async {
    return await _repository.getIntraClusterUsers(campusId);
  }
}

import 'package:dartz/dartz.dart';

import '../entities/location_entity.dart';
import '../../../home/domain/failures.dart';

abstract class ClustersRepository {
  Future<Either<HomeFailure,List<LocationEntity>>> getIntraClusterUsers(String campusId);
}
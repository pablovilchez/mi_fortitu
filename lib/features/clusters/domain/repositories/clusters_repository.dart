import 'package:dartz/dartz.dart';

import '../clusters_failure.dart';
import '../entities/location_entity.dart';


abstract class ClustersRepository {
  Future<Either<ClustersFailure,List<LocationEntity>>> getClustersUsers(String campusId);
}
import 'package:dartz/dartz.dart';

import '../../../home/domain/failures.dart';
import '../entities/coalitions_blocs_entity.dart';

abstract class CoalitionsBlocsRepository {
  Future<Either<HomeFailure, List<CoalitionsBlocsEntity>>> getCampusCoalitions(String campusId);

}
import 'package:dartz/dartz.dart';

import '../coalitions_bloc_failure.dart';
import '../entities/coalitions_blocs_entity.dart';

abstract class CoalitionsBlocsRepository {
  Future<Either<CoalitionsBlocFailure, List<CoalitionsBlocsEntity>>> getCampusCoalitions(String campusId);

}
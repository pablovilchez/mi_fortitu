import 'package:dartz/dartz.dart';

import 'package:mi_fortitu/features/home/domain/home_failure.dart';
import 'package:mi_fortitu/features/home/domain/entities/event_entity.dart';

abstract class HomeRepository {

  Future<Either<HomeFailure,List<EventEntity>>> getUserEvents(String loginName);

  Future<Either<HomeFailure,List<EventEntity>>> getCampusEvents(String campusId);
}

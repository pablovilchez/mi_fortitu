import 'package:dartz/dartz.dart';

import 'package:mi_fortitu/features/home/domain/failures.dart';
import 'package:mi_fortitu/features/home/domain/entities/event_entity.dart';

abstract class HomeRepository {

  Future<Either<HomeFailure,List<EventEntity>>> getIntraUserEvents(String loginName);

  Future<Either<HomeFailure,List<EventEntity>>> getIntraCampusEvents(String campusId);
}

import 'package:dartz/dartz.dart';

import 'package:mi_fortitu/features/home/domain/home_failure.dart';
import 'package:mi_fortitu/features/home/domain/entities/event_entity.dart';

import '../entities/reg_event_data_entity.dart';

abstract class HomeRepository {

  Future<Either<HomeFailure,List<RegEventDataEntity>>> getUserEvents(String loginName);

  Future<Either<HomeFailure,List<EventEntity>>> getCampusEvents(int campusId);

  Future<Either<HomeFailure, RegEventDataEntity>> subscribeToEvent({required int userId, required int eventId});

  Future<Either<HomeFailure, Unit>> unsubscribeFromEvent({required int eventUserId});
}

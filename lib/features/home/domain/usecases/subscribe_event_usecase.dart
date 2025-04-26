import 'package:dartz/dartz.dart';
import 'package:mi_fortitu/features/home/domain/entities/reg_event_data_entity.dart';

import '../home_failure.dart';
import '../repositories/home_repository.dart';

class SubscribeEventUsecase {
  final HomeRepository _repository;

  SubscribeEventUsecase(this._repository);

  Future<Either<HomeFailure, RegEventDataEntity>> call({required int userId, required int eventId}) async {
    return await _repository.subscribeToEvent(userId: userId, eventId: eventId);
  }
}
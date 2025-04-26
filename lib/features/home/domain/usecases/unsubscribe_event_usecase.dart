import 'package:dartz/dartz.dart';

import '../home_failure.dart';
import '../repositories/home_repository.dart';

class UnsubscribeEventUsecase {
  final HomeRepository _repository;

  UnsubscribeEventUsecase(this._repository);

  Future<Either<HomeFailure, Unit>> call({required int eventUserId}) async {
    return await _repository.unsubscribeFromEvent(eventUserId: eventUserId);
  }
}
import 'package:dartz/dartz.dart';

import '../repositories/slots_repository.dart';
import '../slots_failure.dart';

class CreateNewSlotUsecase {
  final SlotsRepository repository;

  CreateNewSlotUsecase(this.repository);

  Future<Either<SlotsFailure, Unit>> call(int userId, DateTime begin, DateTime end) async {
    return await repository.createNewSlot(userId, begin, end);
  }
}
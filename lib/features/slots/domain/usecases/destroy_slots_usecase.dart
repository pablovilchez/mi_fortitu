import 'package:dartz/dartz.dart';
import 'package:mi_fortitu/features/slots/presentation/viewmodels/slot_group_viewmodel.dart';

import '../repositories/slots_repository.dart';
import '../slots_failure.dart';

class DestroySlotsUsecase {
  final SlotsRepository repository;

  DestroySlotsUsecase(this.repository);

  Future<Either<SlotsFailure, Unit>> call(SlotGroupVm slotsGroup) async {
    for (final slot in slotsGroup.slots) {
      final result = await repository.destroySlot(slot.id);
      if (result.isLeft()) {
        return result;
      }
    }
    return Right(unit);
  }
}
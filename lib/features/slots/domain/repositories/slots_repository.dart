import 'package:dartz/dartz.dart';

import '../entities/slot_entity.dart';
import '../slots_failure.dart';

abstract class SlotsRepository {
  Future<Either<SlotsFailure, List<SlotEntity>>> getUserOpenSlots();

  Future<Either<SlotsFailure, Unit>> createNewSlot(int userId, DateTime begin, DateTime end);

  Future<Either<SlotsFailure, Unit>> destroySlot(int slotId);

  Future<Either<SlotsFailure, Unit>> destroySlotsWithScaleTeam(int scaleTeamId);
}

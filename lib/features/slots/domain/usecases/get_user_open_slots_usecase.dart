import 'package:dartz/dartz.dart';
import 'package:mi_fortitu/features/slots/presentation/viewmodels/slot_group_viewmodel.dart';

import '../entities/slot_entity.dart';
import '../repositories/slots_repository.dart';
import '../slots_failure.dart';

class GetUserOpenSlotsUsecase {
  final SlotsRepository slotsRepository;

  GetUserOpenSlotsUsecase(this.slotsRepository);

  Future<Either<SlotsFailure, List<SlotGroupVm>>> call() async {
    final result = await slotsRepository.getUserOpenSlots();
    return result.map((slots) => _groupSlots(slots));
  }

  List<SlotGroupVm> _groupSlots(List<SlotEntity> slots) {
    if (slots.isEmpty) return [];

    slots.sort((a, b) => a.beginAt.compareTo(b.beginAt));
    final List<SlotGroupVm> groups = [];
    List<SlotEntity> currentGroup = [slots.first];

    for (int i = 1; i < slots.length; i++) {
      final previous = currentGroup.last;
      final current = slots[i];

      if (previous.endAt.difference(current.beginAt).inSeconds.abs() <= 60) {
        currentGroup.add(current);
      } else {
        groups.add(
          SlotGroupVm(
            beginAt: currentGroup.first.beginAt,
            endAt: currentGroup.last.endAt,
            slots: List.from(currentGroup),
          ),
        );
        currentGroup = [current];
      }
    }

    groups.add(
      SlotGroupVm(
        beginAt: currentGroup.first.beginAt,
        endAt: currentGroup.last.endAt,
        slots: List.from(currentGroup),
      ),
    );

    return groups;
  }
}

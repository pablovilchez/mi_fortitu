import '../../domain/entities/slot_entity.dart';

class SlotGroupVm {
  final DateTime beginAt;
  final DateTime endAt;
  final List<SlotEntity> slots;
  final bool isReserved;
  final String userToEvaluate;

  const SlotGroupVm({
    required this.beginAt,
    required this.endAt,
    required this.slots,
    this.isReserved = false,
    this.userToEvaluate = 'no_user',
  });
}

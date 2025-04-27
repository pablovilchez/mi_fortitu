import '../../domain/entities/slot_entity.dart';

class SlotGroupVm {
  final DateTime beginAt;
  final DateTime endAt;
  final List<SlotEntity> slots;

  const SlotGroupVm({
    required this.beginAt,
    required this.endAt,
    required this.slots,
  });
}

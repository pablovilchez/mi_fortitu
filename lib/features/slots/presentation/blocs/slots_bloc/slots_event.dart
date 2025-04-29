part of 'slots_bloc.dart';

@immutable
sealed class SlotsEvent {}

class GetSlotsEvent extends SlotsEvent {}

class RefreshSlotsEvent extends SlotsEvent {}

class AddSlotEvent extends SlotsEvent {
  final int userId;
  final DateTime begin;
  final DateTime end;

  AddSlotEvent(this.userId, this.begin, this.end);
}

class DestroySlotsEvent extends SlotsEvent {
  final SlotGroupVm slotsGroup;

  DestroySlotsEvent(this.slotsGroup);
}

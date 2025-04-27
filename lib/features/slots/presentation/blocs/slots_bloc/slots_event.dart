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

class DeleteSlotEvent extends SlotsEvent {
  final int regId;

  DeleteSlotEvent(this.regId);
}

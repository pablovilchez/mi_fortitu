part of 'slots_bloc.dart';

@immutable
sealed class SlotsState {}

final class SlotsInitial extends SlotsState {}

final class SlotsLoading extends SlotsState {}

final class SlotsSuccess extends SlotsState {
  final List<SlotGroupVm> slots;

  SlotsSuccess(this.slots);

  SlotsSuccess copyWithRefreshedSlots(List<SlotGroupVm> newSlots) {
    return SlotsSuccess(newSlots);
  }
}

final class SlotsError extends SlotsState {
  final String error;

  SlotsError(this.error);
}

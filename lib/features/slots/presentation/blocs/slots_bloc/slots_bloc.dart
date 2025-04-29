import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mi_fortitu/features/slots/domain/usecases/create_new_slot_usecase.dart';
import 'package:mi_fortitu/features/slots/presentation/viewmodels/slot_group_viewmodel.dart';

import '../../../domain/slots_failure.dart';
import '../../../domain/usecases/destroy_slots_usecase.dart';
import '../../../domain/usecases/get_user_open_slots_usecase.dart';

part 'slots_event.dart';
part 'slots_state.dart';

class SlotsBloc extends Bloc<SlotsEvent, SlotsState> {
  final GetUserOpenSlotsUsecase getSlotsUsecase;
  final CreateNewSlotUsecase createNewSlotUsecase;
  final DestroySlotsUsecase destroySlotsUsecase;

  SlotsBloc(this.getSlotsUsecase, this.createNewSlotUsecase, this.destroySlotsUsecase)
    : super(SlotsInitial()) {
    on<GetSlotsEvent>(_onGetSlots);
    on<RefreshSlotsEvent>(_onRefreshSlots);
    on<AddSlotEvent>(_onAddSlot);
    on<DestroySlotsEvent>(_onDestroySlots);
  }

  Future<void> _onGetSlots(GetSlotsEvent event, Emitter<SlotsState> emit) async {
    emit(SlotsLoading());
    final result = await getSlotsUsecase.call();

    result.fold(
      (failure) => emit(SlotsError(failure.toString())),
      (slots) => emit(SlotsSuccess(slots)),
    );
  }

  Future<void> _onRefreshSlots(RefreshSlotsEvent event, Emitter<SlotsState> emit) async {
    if (state is SlotsSuccess) {
      final currentState = state as SlotsSuccess;
      emit(SlotsLoading());
      final result = await getSlotsUsecase.call();
      result.fold(
        (failure) => emit(SlotsError(failure.toString())),
        (slots) => emit(currentState.copyWithRefreshedSlots(slots)),
      );
    }
  }

  Future<void> _onAddSlot(AddSlotEvent event, Emitter<SlotsState> emit) async {
    final result = await createNewSlotUsecase.call(event.userId, event.begin, event.end);
    result.fold((failure) => emit(SlotsError(failure.toString())), (unit) => emit(SlotsInitial()));
  }

  Future<void> _onDestroySlots(DestroySlotsEvent event, Emitter<SlotsState> emit) async {
    if (state is! SlotsSuccess) return;

    final currentState = state as SlotsSuccess;
    final slotIdsToDestroy = event.slotsGroup.slots.map((slot) => slot.id).toList();

    final currentSlotList = currentState.slots.expand((group) => group.slots).toList();

    final idsFree = currentSlotList.where((slot) => slot.scaleTeam == null && slotIdsToDestroy.contains(slot.id)).map((s) => s.id).toList();

    if (idsFree.isEmpty) {
      return;
    }

    final slotsToDelete = event.slotsGroup.slots.where((slot) => idsFree.contains(slot.id)).toList();

    for (final slot in slotsToDelete) {
      final result = await destroySlotsUsecase.repository.destroySlot(slot.id);
      if (result.isLeft()) {
        emit(SlotsError(result.swap().getOrElse(() => SlotsFailure('Unknown error')).toString()));
        return;
      }
    }
    emit(SlotsInitial());
  }
}

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mi_fortitu/features/slots/domain/usecases/create_new_slot_usecase.dart';
import 'package:mi_fortitu/features/slots/presentation/viewmodels/slot_group_viewmodel.dart';

import '../../../domain/usecases/get_user_open_slots_usecase.dart';

part 'slots_event.dart';
part 'slots_state.dart';

class SlotsBloc extends Bloc<SlotsEvent, SlotsState> {
  final GetUserOpenSlotsUsecase getSlotsUsecase;
  final CreateNewSlotUsecase createNewSlotUsecase;

  SlotsBloc(this.getSlotsUsecase, this.createNewSlotUsecase) : super(SlotsInitial()) {
    on<GetSlotsEvent>(_onGetSlots);
    on<RefreshSlotsEvent>(_onRefreshSlots);
    on<AddSlotEvent>(_onAddSlot);
    // on<DeleteSlotEvent>(_onDeleteSlot);
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
    result.fold(
      (failure) => emit(SlotsError(failure.toString())),
      (unit) => emit(SlotsInitial()),
    );
  }

  // Future<void> _onDeleteSlot(DeleteSlotEvent event, Emitter<SlotsState> emit) async {
  //
  // }
}

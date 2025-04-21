import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mi_fortitu/features/home/domain/usecases/get_events_usecase.dart';

import '../../viewmodels/event_viewmodel.dart';

part 'events_event.dart';
part 'events_state.dart';

class EventsBloc extends Bloc<EventsEvent, EventsState> {
  final GetEventsUsecase getEventsUsecase;
  EventsBloc(this.getEventsUsecase) : super(IntraEventsInitial()) {
    on<GetIntraEventsEvent>(_onGetIntraEvents);
    on<RefreshIntraEventsEvent>(_onRefreshIntraEvents);
  }

  Future<void> _onGetIntraEvents(
    GetIntraEventsEvent event,
    Emitter<EventsState> emit,
  ) async {
    emit(IntraEventsLoading());
    final result = await getEventsUsecase.call(event.loginName, event.campusId);
    result.fold(
      (failure) => emit(IntraEventsError(failure.toString())),
      (events) => emit(IntraEventsSuccess(events, event.loginName, event.campusId)),
    );
  }

  Future<void> _onRefreshIntraEvents(
    RefreshIntraEventsEvent event,
    Emitter<EventsState> emit,
  ) async {
    if (state is IntraEventsSuccess) {
      final currentState = state as IntraEventsSuccess;
      emit(IntraEventsLoading());
      final result = await getEventsUsecase.call(currentState.loginName, currentState.campusId);
      result.fold(
        (failure) => emit(IntraEventsError(failure.toString())),
        (events) => emit(IntraEventsSuccess(events, currentState.loginName, currentState.campusId)),
      );
    }
  }
}

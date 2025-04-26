import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mi_fortitu/features/home/domain/usecases/get_events_usecase.dart';
import 'package:mi_fortitu/features/home/domain/usecases/subscribe_event_usecase.dart';
import 'package:mi_fortitu/features/home/domain/usecases/unsubscribe_event_usecase.dart';

import '../../viewmodels/event_viewmodel.dart';

part 'events_event.dart';
part 'events_state.dart';

class EventsBloc extends Bloc<EventsEvent, EventsState> {
  final GetEventsUsecase getEventsUsecase;
  final SubscribeEventUsecase subscribeUsecase;
  final UnsubscribeEventUsecase unsubscribeUsecase;

  EventsBloc(this.getEventsUsecase, this.subscribeUsecase, this.unsubscribeUsecase)
    : super(IntraEventsInitial()) {
    on<GetIntraEventsEvent>(_onGetIntraEvents);
    on<RefreshIntraEventsEvent>(_onRefreshIntraEvents);
    on<SubscribeToEventEvent>(_onSubscribe);
    on<UnsubscribeFromEventEvent>(_onUnsubscribe);
  }

  Future<void> _onGetIntraEvents(GetIntraEventsEvent event, Emitter<EventsState> emit) async {
    emit(IntraEventsLoading());
    final result = await getEventsUsecase.call(event.loginName, event.campusId);
    result.fold(
      (failure) => emit(IntraEventsError(failure.toString())),
      (events) => emit(IntraEventsSuccess(events, event.loginName, event.userId, event.campusId)),
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
        (events) => emit(currentState.copyWithRefreshedEvents(events)),
      );
    }
  }

  Future<void> _onSubscribe(SubscribeToEventEvent event, Emitter<EventsState> emit) async {
    if (state is IntraEventsSuccess) {
      final currentEventsState = state as IntraEventsSuccess;

      final result = await subscribeUsecase(userId: currentEventsState.userId, eventId: event.event.details.id);
      result.fold((failure) => emit(IntraEventsError(failure.message)), (newRegister) {
        final updatedEvent = event.event.copyWith(
          status: EventStatus.subscribed,
          registerId: newRegister.id,
        );

        final updatedState = currentEventsState.copyWithUpdatedEvent(updatedEvent);
        emit(updatedState);
      });
    }
  }

  Future<void> _onUnsubscribe(UnsubscribeFromEventEvent event, Emitter<EventsState> emit) async {
    if (state is IntraEventsSuccess) {
      final currentState = state as IntraEventsSuccess;

      final result = await unsubscribeUsecase(eventUserId: event.event.registerId);
      result.fold((failure) => emit(IntraEventsError(failure.message)), (_) {
        final updatedEvent = event.event.copyWith(status: EventStatus.notSubscribed, registerId: 0);

        final updatedState = currentState.copyWithUpdatedEvent(updatedEvent);
        emit(updatedState);
      });
    }
  }
}

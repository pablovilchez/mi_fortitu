import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
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
      (events) => emit(
        IntraEventsSuccess(
          events,
          event.loginName,
          event.userId,
          event.campusId,
          errorMessage: null,
        ),
      ),
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
        (events) => emit(currentState.copyWith(events: events, errorMessage: null)),
      );
    }
  }

  Future<void> _onSubscribe(SubscribeToEventEvent event, Emitter<EventsState> emit) async {
    if (state is IntraEventsSuccess) {
      final currentState = state as IntraEventsSuccess;

      final result = await subscribeUsecase(
        userId: currentState.userId,
        eventId: event.event.details.id,
      );

      result.fold(
        (failure) {
          final updatedEvent = event.event.copyWith(status: EventStatus.failed);

          final updatedEvents =
              currentState.events.map((e) {
                return e.details.id == event.event.details.id ? updatedEvent : e;
              }).toList();

          emit(
            currentState.copyWith(
              events: updatedEvents,
              errorMessage: tr('events.messages.failed'),
            ),
          );
        },
        (newRegister) {
          final updatedEvent = event.event.copyWith(
            status: EventStatus.subscribed,
            registerId: newRegister.id,
          );

          final updatedEvents =
              currentState.events.map((e) {
                return e.details.id == event.event.details.id ? updatedEvent : e;
              }).toList();

          emit(currentState.copyWith(events: updatedEvents, errorMessage: null));
        },
      );
    }
  }

  Future<void> _onUnsubscribe(UnsubscribeFromEventEvent event, Emitter<EventsState> emit) async {
    if (state is IntraEventsSuccess) {
      final currentState = state as IntraEventsSuccess;

      final result = await unsubscribeUsecase(eventUserId: event.event.registerId);
      result.fold(
        (failure) {
          emit(currentState.copyWith(errorMessage: failure.message));
        },
        (_) {
          final updatedEvent = event.event.copyWith(
            status: EventStatus.notSubscribed,
            registerId: 0,
          );

          final updatedEvents =
              currentState.events.map((e) {
                return e.details.id == event.event.details.id ? updatedEvent : e;
              }).toList();
          emit(currentState.copyWith(events: updatedEvents, errorMessage: null));
        },
      );
    }
  }
}

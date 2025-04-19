import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mi_fortitu/features/home/domain/usecases/get_events_usecase.dart';

import '../../../domain/entities/event_entity.dart';
import '../../viewmodels/event_viewmodel.dart';

part 'events_event.dart';
part 'events_state.dart';

class EventsBloc extends Bloc<EventsEvent, EventsState> {
  final GetEventsUsecase getEventsUsecase;
  EventsBloc(this.getEventsUsecase) : super(IntraEventsInitial()) {
    on<GetIntraEventsEvent>(_onGetIntraEvents);
  }

  Future<void> _onGetIntraEvents(
    GetIntraEventsEvent event,
    Emitter<EventsState> emit,
  ) async {
    emit(IntraEventsLoading());
    final result = await getEventsUsecase.call(event.loginName, event.campusId);
    result.fold(
      (failure) => emit(IntraEventsError(failure.toString())),
      (events) => emit(IntraEventsSuccess(events)),
    );
  }
}

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mi_fortitu/features/home/domain/usecases/get_events_usecase.dart';

import '../../../domain/entities/intra_event.dart';

part 'intra_events_event.dart';
part 'intra_events_state.dart';

class IntraEventsBloc extends Bloc<IntraEventsEvent, IntraEventsState> {
  IntraEventsBloc() : super(IntraEventsInitial()) {
    on<GetIntraEventsEvent>(_onGetIntraEvents);
  }

  Future<void> _onGetIntraEvents(
    GetIntraEventsEvent event,
    Emitter<IntraEventsState> emit,
  ) async {
    emit(IntraEventsLoading());
    final result = await GetEventsUsecase().call();
    result.fold(
      (failure) => emit(IntraEventsError(failure.toString())),
      (events) => emit(IntraEventsSuccess(events)),
    );
  }
}

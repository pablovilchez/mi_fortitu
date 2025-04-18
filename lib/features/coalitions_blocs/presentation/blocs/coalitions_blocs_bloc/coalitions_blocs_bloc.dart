import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../domain/usecases/get_coalitions_blocs_usecase.dart';
import '../../../domain/entities/coalitions_blocs_entity.dart';


part 'coalitions_blocs_event.dart';
part 'coalitions_blocs_state.dart';

class CoalitionsBlocsBloc extends Bloc<CoalitionsBlocsEvent, CoalitionsBlocsState> {
  final GetCoalitionsBlocsUsecase getCoalitionsUsecase;

  CoalitionsBlocsBloc(this.getCoalitionsUsecase) : super(IntraCoalitionsInitial()) {
    on<GetCoalitionsEvent>(_onGetCoalitions);
  }

  Future<void> _onGetCoalitions(
    GetCoalitionsEvent event,
    Emitter<CoalitionsBlocsState> emit,
  ) async {
    emit(IntraCoalitionsLoading());
    final result = await getCoalitionsUsecase.call(event.campusId);
    await result.fold(
      (failure) async {
        emit(IntraCoalitionsError(failure.toString()));
      },
      (coalitions) async {
        return emit(IntraCoalitionsSuccess(coalitions));
      },
    );
  }
}

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../domain/entities/cursus_coalitions_entity.dart';
import '../../../domain/usecases/get_coalitions_usecase.dart';

part 'intra_coalitions_event.dart';
part 'intra_coalitions_state.dart';

class IntraCoalitionsBloc extends Bloc<IntraCoalitionsEvent, IntraCoalitionsState> {
  final GetCoalitionsUsecase getCoalitionsUsecase;

  IntraCoalitionsBloc({required this.getCoalitionsUsecase}) : super(IntraCoalitionsInitial()) {
    on<GetCoalitionsEvent>(_onGetCoalitions);
  }

  Future<void> _onGetCoalitions(
    GetCoalitionsEvent event,
    Emitter<IntraCoalitionsState> emit,
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

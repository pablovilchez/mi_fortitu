import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mi_fortitu/features/home/domain/usecases/get_mock_profile_usecase.dart';

import '../../../domain/entities/intra_profile.dart';
import '../../viewmodels/profile_summary_viewmodel.dart';

part 'intra_profile_event.dart';

part 'intra_profile_state.dart';

class IntraProfileBloc extends Bloc<IntraProfileEvent, IntraProfileState> {
  IntraProfileBloc() : super(IntraProfileLoading()) {
    on<GetIntraProfileEvent>(_onGetIntraProfile);
  }


  Future<void> _onGetIntraProfile(GetIntraProfileEvent event,
      Emitter<IntraProfileState> emit) async {
    emit(IntraProfileLoading());

    final result = await GetMockProfileUseCase().call(event.login);
    result.fold(
          (failure) => emit(IntraProfileError(failure.toString())),
          (profile) => emit(IntraProfileSuccess(profile)),
    );
  }
}


import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mi_fortitu/features/home/domain/usecases/get_mock_profile_usecase.dart';

import '../../../domain/entities/intra_profile.dart';

part 'intra_search_profile_event.dart';

part 'intra_search_profile_state.dart';

class IntraSearchProfileBloc extends Bloc<IntraSearchProfileEvent, IntraSearchProfileState> {
  IntraSearchProfileBloc() : super(IntraSearchProfileInitial()) {
    on<GetIntraSearchProfileEvent>(_onGetIntraProfile);
  }


  Future<void> _onGetIntraProfile(GetIntraSearchProfileEvent event,
      Emitter<IntraSearchProfileState> emit) async {
    emit(IntraSearchProfileLoading());

    final result = await GetMockProfileUseCase().call(event.login);
    result.fold(
          (failure) => emit(IntraSearchProfileError(failure.toString())),
          (profile) => emit(IntraSearchProfileSuccess(profile)),
    );
  }
}


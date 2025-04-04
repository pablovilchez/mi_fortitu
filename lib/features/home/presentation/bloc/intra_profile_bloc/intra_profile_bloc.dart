import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mi_fortitu/features/home/domain/usecases/get_profile_usecase.dart';

import '../../../domain/entities/intra_profile.dart';
import '../../viewmodels/intra_profile_summary_vm.dart';

part 'intra_profile_event.dart';

part 'intra_profile_state.dart';

class IntraProfileBloc extends Bloc<IntraProfileEvent, IntraProfileState> {
  IntraProfileBloc() : super(IntraProfileInitial()) {
    on<GetIntraProfileEvent>(_onGetIntraProfile);
  }


  Future<void> _onGetIntraProfile(GetIntraProfileEvent event,
      Emitter<IntraProfileState> emit) async {
    emit(IntraProfileLoading());

    final result = await GetProfileUseCase().call(event.login);
    result.fold(
          (failure) => emit(IntraProfileError(failure.toString())),
          (profile) => emit(IntraProfileSuccess(profile)),
    );
  }
}


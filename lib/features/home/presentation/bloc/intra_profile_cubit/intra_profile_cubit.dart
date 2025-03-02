import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mi_fortitu/features/home/domain/usecases/get_mock_profile_usecase.dart';

import '../../../domain/entities/intra_profile.dart';

part 'intra_profile_state.dart';

class IntraProfileCubit extends Cubit<IntraProfileState> {
  late IntraProfile intraProfile;

  IntraProfileCubit() : super(IntraProfileLoading()) {
    getMockProfile();
  }

  Future<void> getMockProfile() async {
    final result = await GetMockProfileUseCase().call('pvilchez');
    result.fold(
      (failure) => emit(IntraProfileFailure()),
      (profile) {
        intraProfile = profile;
        emit(IntraProfileSuccess());
      },
    );
  }
}

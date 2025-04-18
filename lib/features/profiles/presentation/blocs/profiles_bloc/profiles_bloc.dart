import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mi_fortitu/features/profiles/domain/usecases/get_profile_usecase.dart';

import '../../../domain/entities/user_entity.dart';
import '../../viewmodels/intra_profile_summary_vm.dart';


part 'profiles_event.dart';
part 'profiles_state.dart';

class ProfilesBloc extends Bloc<ProfilesEvent, ProfilesState> {
  final GetProfileUsecase getProfileUsecase;

  ProfilesBloc(this.getProfileUsecase) : super(ProfileInitial()) {
    on<GetIntraProfileEvent>(_onGetIntraProfile);
  }

  Future<void> _onGetIntraProfile(
    GetIntraProfileEvent event,
    Emitter<ProfilesState> emit,
  ) async {
    emit(ProfileLoading());

    final result = await getProfileUsecase.call('me');
    result.fold(
      (failure) => emit(ProfileError(failure.toString())),
      (profile) => emit(ProfileSuccess(profile)),
    );
  }
}

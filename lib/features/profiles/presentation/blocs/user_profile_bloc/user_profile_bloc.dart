import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mi_fortitu/features/profiles/domain/usecases/get_profile_usecase.dart';

import '../../../domain/entities/user_entity.dart';
import '../../viewmodels/intra_profile_summary_vm.dart';


part 'user_profile_event.dart';
part 'user_profile_state.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  final GetProfileUsecase getProfileUsecase;

  UserProfileBloc(this.getProfileUsecase) : super(UserProfileInitial()) {
    on<GetUserProfileEvent>(_onGetIntraProfile);
  }

  Future<void> _onGetIntraProfile(
    GetUserProfileEvent event,
    Emitter<UserProfileState> emit,
  ) async {
    emit(UserProfileLoading());

    final result = await getProfileUsecase.call('me');
    result.fold(
      (failure) => emit(UserProfileError(failure.toString())),
      (profile) => emit(UserProfileSuccess(profile)),
    );
  }
}

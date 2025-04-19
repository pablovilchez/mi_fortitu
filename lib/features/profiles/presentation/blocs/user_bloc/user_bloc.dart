import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mi_fortitu/features/profiles/domain/usecases/get_profile_usecase.dart';

import '../../../domain/entities/user_entity.dart';
import '../../viewmodels/intra_profile_summary_vm.dart';


part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final GetProfileUsecase getProfileUsecase;

  UserBloc(this.getProfileUsecase) : super(UserInitial()) {
    on<GetUserProfileEvent>(_onGetIntraProfile);
  }

  Future<void> _onGetIntraProfile(
    GetUserProfileEvent event,
    Emitter<UserState> emit,
  ) async {
    emit(UserLoading());

    final result = await getProfileUsecase.call('me');
    result.fold(
      (failure) => emit(UserError(failure.toString())),
      (profile) => emit(UserSuccess(profile)),
    );
  }
}

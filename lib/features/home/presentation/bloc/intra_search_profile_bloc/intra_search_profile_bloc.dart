import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mi_fortitu/features/home/domain/usecases/get_profile_usecase.dart';

import '../../../domain/entities/user_entity.dart';

part 'intra_search_profile_event.dart';

part 'intra_search_profile_state.dart';

class IntraSearchProfileBloc extends Bloc<IntraSearchProfileEvent, IntraSearchProfileState> {
  final GetProfileUsecase getProfileUsecase;
  IntraSearchProfileBloc(
      {required this.getProfileUsecase}
      ) : super(IntraSearchProfileInitial()) {
    on<GetIntraSearchProfileEvent>(_onGetIntraProfile);
  }


  Future<void> _onGetIntraProfile(GetIntraSearchProfileEvent event,
      Emitter<IntraSearchProfileState> emit) async {
    emit(IntraSearchProfileLoading());

    final result = await getProfileUsecase.call(event.login);
    result.fold(
          (failure) => emit(IntraSearchProfileError(failure.toString())),
          (profile) => emit(IntraSearchProfileSuccess(profile)),
    );
  }
}


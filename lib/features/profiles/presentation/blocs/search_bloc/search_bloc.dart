import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../domain/entities/user_entity.dart';
import '../../../domain/usecases/get_profile_usecase.dart';
import '../../viewmodels/intra_profile_summary_vm.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final GetProfileUsecase getProfileUsecase;

  SearchBloc(this.getProfileUsecase) : super(SearchInitial()) {
    on<GetSearchProfileEvent>(_onGetSearchProfile);
  }

  Future<void> _onGetSearchProfile(
    GetSearchProfileEvent event,
    Emitter<SearchState> emit,
  ) async {
    emit(SearchLoading());

    await Future.delayed(const Duration(seconds: 2));

    final result = await getProfileUsecase.call(event.loginName);
    result.fold(
          (failure) => emit(SearchError(failure.toString())),
          (profile) => emit(SearchSuccess(profile)),
    );
  }
}

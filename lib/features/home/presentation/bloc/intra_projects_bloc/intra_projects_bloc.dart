import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../viewmodels/projects_users_vm.dart';

part 'intra_projects_event.dart';
part 'intra_projects_state.dart';

class IntraProjectsBloc extends Bloc<IntraProjectsEvent, IntraProjectsState> {
  IntraProjectsBloc() : super(IntraProjectsInitial()) {
    on<SearchPartnersEvent>(_searchPartners);
  }

  void _searchPartners(SearchPartnersEvent event, Emitter<IntraProjectsState> emit) {
    emit(IntraProjectsLoading());

  }
}

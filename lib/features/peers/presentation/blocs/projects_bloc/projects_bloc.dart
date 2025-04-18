import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mi_fortitu/features/peers/domain/usecases/get_project_users_usecase.dart';

part 'projects_event.dart';

part 'projects_state.dart';

class ProjectsBloc extends Bloc<ProjectsEvent, ProjectsState> {
  final GetProjectUsersUseCase getRoleUsecase;

  ProjectsBloc(this.getRoleUsecase) : super(IntraProjectsInitial()) {
    on<SearchPartnersEvent>(_searchPartners);
  }

  void _searchPartners(SearchPartnersEvent event, Emitter<ProjectsState> emit) {
    emit(IntraProjectsLoading());
  }
}

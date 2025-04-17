part of 'intra_projects_bloc.dart';

@immutable
sealed class IntraProjectsState {}

final class IntraProjectsInitial extends IntraProjectsState {}

final class IntraProjectsLoading extends IntraProjectsState {}

final class IntraProjectsSuccess extends IntraProjectsState {
  final List<ProjectsUsersVm> projectsUsers;

  IntraProjectsSuccess(this.projectsUsers);
}

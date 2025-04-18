part of 'projects_bloc.dart';

@immutable
sealed class ProjectsState {}

final class IntraProjectsInitial extends ProjectsState {}

final class IntraProjectsLoading extends ProjectsState {}

final class IntraProjectsSuccess extends ProjectsState {}

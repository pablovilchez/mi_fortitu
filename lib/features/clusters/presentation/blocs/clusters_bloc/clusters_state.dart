part of 'clusters_bloc.dart';

@immutable
sealed class ClustersState {}

final class ClustersInitial extends ClustersState {}

final class ClustersLoading extends ClustersState {}

final class ClustersSuccess extends ClustersState {
  final List<ClusterVm> campusClusters;

  ClustersSuccess(this.campusClusters);
}

final class ClustersError extends ClustersState {
  final String errorMessage;

  ClustersError(this.errorMessage);
}

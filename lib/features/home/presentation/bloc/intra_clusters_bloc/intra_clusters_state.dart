part of 'intra_clusters_bloc.dart';

@immutable
sealed class IntraClustersState {}

final class IntraClustersInitial extends IntraClustersState {}

final class IntraClustersLoading extends IntraClustersState {}

final class IntraClustersSuccess extends IntraClustersState {
  final List<ClusterVm> campusClusters;

  IntraClustersSuccess(this.campusClusters);
}

final class IntraClustersError extends IntraClustersState {
  final String errorMessage;

  IntraClustersError(this.errorMessage);
}

part of 'intra_clusters_bloc.dart';

@immutable
sealed class IntraClustersEvent {}

class GetCampusClustersEvent extends IntraClustersEvent {
  final String campusId;

  GetCampusClustersEvent({required this.campusId});
}

class RefreshClustersEvent extends IntraClustersEvent {}

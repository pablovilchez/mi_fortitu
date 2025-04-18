part of 'clusters_bloc.dart';

@immutable
sealed class ClustersEvent {}

class GetCampusClustersEvent extends ClustersEvent {
  final String campusId;

  GetCampusClustersEvent({required this.campusId});
}

class RefreshClustersEvent extends ClustersEvent {}

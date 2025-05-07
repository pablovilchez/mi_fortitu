import '../../domain/entities/location_entity.dart';

class ClusterVm {
  final String clusterId;
  final String clusterName;
  final List<RowViewModel> rows;

  ClusterVm({required this.clusterId, required this.clusterName, required this.rows});
}

class RowViewModel {
  final String rowId;
  final List<StationViewModel> stations;

  RowViewModel({required this.rowId, required this.stations});
}

class StationViewModel {
  final String stationId;
  final LocationEntity? user;

  StationViewModel({required this.stationId, this.user});
}

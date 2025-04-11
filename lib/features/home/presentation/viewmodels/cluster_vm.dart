import '../../domain/entities/cluster_user_entity.dart';

class ClusterVm {
  final String name;
  final List<RowViewModel> rows;

  ClusterVm({required this.name, required this.rows});
}

class RowViewModel {
  final int rowNumber;
  final String starts;
  final List<StationViewModel> stations;

  RowViewModel({required this.rowNumber, required this.starts, required this.stations});
}

class StationViewModel {
  final int stationNumber;
  final ClusterUserEntity? user;

  StationViewModel({required this.stationNumber, this.user});
}

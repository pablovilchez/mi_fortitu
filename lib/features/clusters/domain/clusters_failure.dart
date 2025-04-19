abstract class ClustersFailure {
  final String message;

  ClustersFailure(this.message);

  @override
  String toString() => message;
}

class DataFailure extends ClustersFailure {
  DataFailure(String code) : super('Error $code fetching cluster data');
}

class MapFailure extends ClustersFailure {
  MapFailure(String code) : super('Error $code parsing cluster data');
}
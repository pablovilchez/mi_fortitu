abstract class PeersFailure {
  final String message;

  PeersFailure(this.message);

  @override
  String toString() => message;
}

class DataFailure extends PeersFailure {
  DataFailure(String code) : super('Error $code fetching data');

  @override
  String toString() => message;
}

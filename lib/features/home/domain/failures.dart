abstract class Failure {
  final String message;

  Failure(this.message);

  @override
  String toString() => message;
}

class ServerDataFailure extends Failure {
  ServerDataFailure(super.message);

  @override
  String toString() => message;
}

class ParsingDataFailure extends Failure {
  ParsingDataFailure(super.message);

  @override
  String toString() => message;
}

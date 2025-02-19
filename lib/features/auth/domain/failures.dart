abstract class Failure {
  final String message;

  Failure(this.message);

  @override
  String toString() => message;
}

class AuthFailure extends Failure {
  AuthFailure(String message) : super(message);
}

class ServerFailure extends Failure {
  ServerFailure(super.message);
}

class NetworkFailure extends Failure {
  NetworkFailure(super.message);
}

class InvalidInputFailure extends Failure {
  InvalidInputFailure(super.message);
}


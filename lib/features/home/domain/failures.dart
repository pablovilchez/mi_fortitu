abstract class HomeFailure {
  final String message;

  HomeFailure(this.message);

  @override
  String toString() => message;
}

class ServerDataFailure extends HomeFailure {
  ServerDataFailure(super.message);

  @override
  String toString() => message;
}

class ParsingDataFailure extends HomeFailure {
  ParsingDataFailure(super.message);

  @override
  String toString() => message;
}

class AuthFailure extends HomeFailure {
  AuthFailure(super.message);

  @override
  String toString() => message;
}

class UnexpectedFailure extends HomeFailure {
  UnexpectedFailure(super.message);

  @override
  String toString() => message;
}
abstract class HomeFailure {
  final String message;

  HomeFailure(this.message);

  @override
  String toString() => message;
}

class DataFailure extends HomeFailure {
  DataFailure(String code) : super('Error $code fetching data');

  @override
  String toString() => message;
}

class UnexpectedFailure extends HomeFailure {
  UnexpectedFailure() : super('Unexpected Home error');

  @override
  String toString() => message;
}
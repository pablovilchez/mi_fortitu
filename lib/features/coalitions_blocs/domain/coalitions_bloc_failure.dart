abstract class CoalitionsBlocFailure {
  final String message;

  CoalitionsBlocFailure(this.message);

  @override
  String toString() => message;
}

class DataFailure extends CoalitionsBlocFailure {
  DataFailure(String code) : super('Error $code fetching data');

  @override
  String toString() => message;
}

class EmptyDataFailure extends CoalitionsBlocFailure {
  EmptyDataFailure() : super('Coalitions data is empty');

  @override
  String toString() => message;
}
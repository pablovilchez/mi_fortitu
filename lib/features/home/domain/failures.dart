abstract class Failure {
  final String message;

  Failure(this.message);

  @override
  String toString() => message;
}

class ProfileDataFailure extends Failure {
  ProfileDataFailure(String message) : super(message);

  @override
  String toString() => 'Profile data failure: Data not found.';
}

class ParsingDataFailure extends Failure {
  ParsingDataFailure(String message) : super(message);

  @override
  String toString() => 'Parsing data failure: Data not found.';
}
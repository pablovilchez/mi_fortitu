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
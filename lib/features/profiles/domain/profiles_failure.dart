abstract class ProfilesFailure {
  final String message;

  ProfilesFailure(this.message);

  @override
  String toString() => message;
}

class DataFailure extends ProfilesFailure {
  DataFailure(String code) : super('Error $code fetching data');

  @override
  String toString() => message;
}

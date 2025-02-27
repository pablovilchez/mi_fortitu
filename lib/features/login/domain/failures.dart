abstract class Failure {
  final String message;

  Failure(this.message);

  @override
  String toString() => message;
}

// Intra failures
class EnvDataFailure extends Failure {
  EnvDataFailure(super.message);

  @override
  String toString() => 'Environment data failure: Data not found.';
}

class IntraLoginFailure extends Failure {
  IntraLoginFailure(super.message);

  @override
  String toString() => 'Cannot obtain Intra credentials.';
}

// Supabase failures
class AuthFailure extends Failure {
  AuthFailure(super.message);

  @override
  String toString() => 'Incorrect email or password.';
}

class RegisterFailure extends Failure {
  RegisterFailure(super.message);

  @override
  String toString() => 'Cannot register user. Already exists?';
}

class DatabaseFailure extends Failure {
  DatabaseFailure(super.message);

  @override
  String toString() => 'Cannot create or get profile data.';
}

class NoCredentialsFailure extends Failure {
  NoCredentialsFailure(super.message);

  @override
  String toString() => 'No user credentials or data found.';
}

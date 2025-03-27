abstract class Failure {
  final String message;

  Failure(this.message);

  @override
  String toString() => message;
}

// Intra failures
class EnvDataFailure extends Failure {
  EnvDataFailure(super.message);
}

class IntraLoginFailure extends Failure {
  IntraLoginFailure(super.message);
}

// Supabase failures
class AuthFailure extends Failure {
  AuthFailure(super.message);
}

class RegisterFailure extends Failure {
  RegisterFailure(super.message);
}

class DatabaseFailure extends Failure {
  DatabaseFailure(super.message);
}

class CredentialsFailure extends Failure {
  CredentialsFailure(super.message);
}

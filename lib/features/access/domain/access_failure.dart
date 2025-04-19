abstract class AccessFailure {
  final String message;

  AccessFailure(this.message);

  @override
  String toString() => message;
}

// Intra failures

class IntraLoginFailure extends AccessFailure {
  IntraLoginFailure(String code) : super('Error $code trying to obtain intra token');
}

// Supabase failures

class DbLoginFailure extends AccessFailure {
  DbLoginFailure(String code) : super('Error $code trying to login in db');
}

class RegisterFailure extends AccessFailure {
  RegisterFailure(String code) : super('Error $code trying to register in db');
}

class CredentialsFailure extends AccessFailure {
  CredentialsFailure(String code) : super('Error $code trying to get db credentials');
}

class DatabaseFailure extends AccessFailure {
  DatabaseFailure(String code) : super('Error $code trying to get db data');
}

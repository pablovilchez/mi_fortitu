abstract class SettingsFailure {
  final String message;
  SettingsFailure(this.message);
}

class LogoutFailure extends SettingsFailure {
  LogoutFailure(super.message);
}

class SettingsException implements Exception {
  final String message;

  SettingsException(this.message);

  @override
  String toString() {
    return 'SettingsException: $message';
  }
}

class DatabaseException extends SettingsException {
  DatabaseException(super.message);
}
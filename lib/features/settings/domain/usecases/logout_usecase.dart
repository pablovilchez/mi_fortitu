import '../repositories/settings_repository.dart';

class LogoutUsecase {
  final SettingsRepository _authRepository;

  LogoutUsecase(this._authRepository);

  Future<void> call() async {
    await _authRepository.logoutDatabase();
  }
}
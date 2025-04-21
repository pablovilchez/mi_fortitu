import '../../domain/repositories/settings_repository.dart';
import '../datasources/settings_datasource.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final SettingsDatasource datasource;

  SettingsRepositoryImpl(this.datasource);

  @override
  Future<void> logoutDatabase() async {
    await datasource.logoutSupa();
  }
}

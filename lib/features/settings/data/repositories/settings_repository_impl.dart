import 'package:dartz/dartz.dart';

import '../../domain/repositories/settings_repository.dart';
import '../../domain/settings_failure.dart';
import '../datasources/settings_datasource.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final SettingsDatasource datasource;

  SettingsRepositoryImpl(this.datasource);

  @override
  Future<Either<SettingsFailure, Unit>> logoutDatabase() async {
    final result = await datasource.logoutSupa();
    return result.fold(
          (exception) => Left(LogoutFailure(exception.toString())),
          (success) => Right(unit),
    );
  }
}

import 'package:dartz/dartz.dart';

import '../settings_failure.dart';

abstract class SettingsRepository {
  Future<Either<SettingsFailure, Unit>> logoutDatabase();
}

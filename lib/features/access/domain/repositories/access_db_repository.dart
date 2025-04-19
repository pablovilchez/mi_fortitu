import 'package:dartz/dartz.dart';

import 'package:mi_fortitu/features/access/domain/access_failure.dart';
import 'package:mi_fortitu/features/access/domain/entities/db_login_entity.dart';

abstract class AccessDbRepository {
  Future<Either<AccessFailure, DbLoginEntity>> login(String email, String password);

  Future<Either<AccessFailure, DbLoginEntity>> register(String email, String password);

  Future<Either<AccessFailure, Unit>> getToken();

  Future<Either<AccessFailure, String>> getRole();
}

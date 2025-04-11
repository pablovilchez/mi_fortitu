import 'package:dartz/dartz.dart';

import 'package:mi_fortitu/features/auth/domain/failures.dart';
import 'package:mi_fortitu/features/auth/domain/entities/db_login_entity.dart';

abstract class AuthDbRepository {
  Future<Either<Failure, DbLoginEntity>> login(String email, String password);

  Future<Either<Failure, DbLoginEntity>> register(String email, String password);

  Future<Either<Failure, Unit>> getToken();

  Future<Either<Failure, String>> getRole();
}

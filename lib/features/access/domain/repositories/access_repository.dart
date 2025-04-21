import 'package:dartz/dartz.dart';

import 'package:mi_fortitu/features/access/domain/access_failure.dart';
import 'package:mi_fortitu/features/access/domain/entities/login_entity.dart';

abstract class AccessRepository {
  Future<Either<AccessFailure, LoginEntity>> login(String email, String password);

  Future<Either<AccessFailure, LoginEntity>> register(String email, String password);

  Future<Either<AccessFailure, Unit>> getToken();

  Future<Either<AccessFailure, String>> getRole();
}

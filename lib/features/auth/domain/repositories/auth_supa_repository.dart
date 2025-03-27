import 'package:dartz/dartz.dart';

import 'package:mi_fortitu/features/auth/domain/failures.dart';
import 'package:mi_fortitu/features/auth/domain/entities/supa_login.dart';

abstract class AuthSupaRepository {
  Future<Either<Failure, SupaLogin>> login(String email, String password);

  Future<Either<Failure, SupaLogin>> register(String email, String password);

  Future<Either<Failure, Unit>> addProfile();

  Future<Either<Failure, Unit>> checkProfileCredentials();

  Future<Either<Failure, String>> getRole();
}

import 'package:dartz/dartz.dart';

import 'package:mi_fortitu/features/auth/domain/entities/intra_user.dart';
import 'package:mi_fortitu/features/auth/domain/failures.dart';

abstract class AuthRepository {
  Future<Either<Failure, Unit>> authLogin(String email, String password);
  Future<Either<Failure, Unit>> authCheck();
  Future<Either<Failure, Unit>> authRegister(String email, String password, String displayName);
  Future<Either<Failure, Unit>> authResetPassword(String password);
  Future<Either<Failure, Unit>> authLogout();
  Future<Either<Failure, bool>> checkApproval();

  Future<Either<Failure, IntraUser>> intraLogin();
  Future<Either<Failure, IntraUser>> getIntraUserProfile(String login);
}
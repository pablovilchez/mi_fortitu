import 'package:dartz/dartz.dart';

import 'package:mi_fortitu/features/auth/domain/entities/auth_user.dart';
import 'package:mi_fortitu/features/auth/domain/failures.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthUser>> authLogin(String email, String password);

  Future<Either<Failure, AuthUser>> authSignIn(String email, String password);
  Future<Either<Failure, Unit>> authSignOut();
  
  Future<Either<Failure, Unit>> authCheck();
  Future<Either<Failure, Unit>> authResetPassword(String password);
  
  Future<Either<Failure, bool>> checkApproval();
}

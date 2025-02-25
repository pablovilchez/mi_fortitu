import 'package:dartz/dartz.dart';
import 'package:mi_fortitu/features/login/domain/entities/supa_login.dart';

import 'package:mi_fortitu/features/login/domain/failures.dart';
import 'package:mi_fortitu/features/login/data/repositories/supa_login_repository.dart';

class SignInUsecase {
  final SupaLoginRepository repository;

  SignInUsecase(this.repository);

  Future<Either<Failure, SupaLogin>> call(String email, String password) async {
    final supaLogin = await repository.register(email, password);

    if (supaLogin.isLeft()) {
      return Left(AuthFailure('Cannot register user'));
    }

    return supaLogin;
  }
}

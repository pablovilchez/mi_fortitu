import 'package:dartz/dartz.dart';

import '../access_failure.dart';
import '../repositories/access_repository.dart';

class RequestAccountRecoveryEmailUsecase {
  final AccessRepository repository;

  RequestAccountRecoveryEmailUsecase(this.repository);

  Future<Either<AccessFailure, Unit>> call(String email) async {
    return await repository.requestAccountRecoveryEmail(email);
  }
}

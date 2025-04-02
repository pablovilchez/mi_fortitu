import 'package:dartz/dartz.dart';

import 'package:mi_fortitu/features/auth/domain/failures.dart';

abstract class AuthIntraRepository {
  Future<Either<Failure, Unit>> requestNewToken();
}

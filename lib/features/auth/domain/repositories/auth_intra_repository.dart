import 'package:dartz/dartz.dart';

import 'package:mi_fortitu/features/auth/data/models/intra_login_model.dart';
import 'package:mi_fortitu/features/auth/domain/failures.dart';

abstract class AuthIntraRepository {
  Future<Either<Failure, IntraLoginModel>> getIntraClient();
}

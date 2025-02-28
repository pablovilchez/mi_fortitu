import 'package:dartz/dartz.dart';

import 'package:mi_fortitu/features/login/domain/entities/intra_login.dart';
import 'package:mi_fortitu/features/login/domain/failures.dart';

import 'package:mi_fortitu/features/login/data/repositories/intra_login_repository.dart';

class GetIntraClientUsecase {
  final repository = IntraLoginRepository();

  Future<Either<Failure, IntraLogin>> call() async {
    return await repository.getIntraClient();
  }
}

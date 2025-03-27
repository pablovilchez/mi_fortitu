import 'package:dartz/dartz.dart';
import 'package:mi_fortitu/features/home/domain/failures.dart';

import '../../data/repositories/home_intra_repository.dart';
import '../entities/intra_profile.dart';

class GetProfileUseCase {
  final repository = HomeIntraRepository();

  Future<Either<Failure, IntraProfile>> call(String loginName) async {
    return repository.getIntraProfile(loginName);
  }
}
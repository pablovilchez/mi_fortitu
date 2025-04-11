import 'package:dartz/dartz.dart';
import 'package:mi_fortitu/features/home/domain/failures.dart';

import '../entities/intra_profile_entity.dart';
import '../repositories/home_intra_repository.dart';

class GetProfileUsecase {
  final HomeIntraRepository repository;

  GetProfileUsecase({required this.repository});

  Future<Either<HomeFailure, IntraProfileEntity>> call(String loginName) async {
    return repository.getIntraProfile(loginName);
  }
}
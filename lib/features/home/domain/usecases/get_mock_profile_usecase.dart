import 'package:dartz/dartz.dart';
import 'package:mi_fortitu/features/home/domain/failures.dart';

import '../../data/repositories/home_intra_repository.dart';
import '../entities/entities.dart';

class GetMockProfileUseCase {
  final repository = HomeIntraRepository();

  Future<Either<Failure, IntraProfile>> call(String loginName) async {
    try {
      final IntraProfile result = await repository.getMockIntraProfile(loginName);
      return Right(result);
    } catch (e) {
      return Left(ProfileDataFailure(e.toString()));
    }
  }
}
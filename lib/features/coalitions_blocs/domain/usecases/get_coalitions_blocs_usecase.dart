import 'package:dartz/dartz.dart';

import '../../../home/domain/failures.dart';
import '../entities/coalitions_blocs_entity.dart';
import '../repositories/coalitions_blocs_repository.dart';

class GetCoalitionsBlocsUsecase {
  final CoalitionsBlocsRepository repository;

  GetCoalitionsBlocsUsecase(this.repository);

  Future<Either<HomeFailure, CoalitionsBlocsEntity>> call(String campusId) async {
    final result = await repository.getCampusCoalitions(campusId);
    return result.fold(
      (failure) => Left(failure),
      (cursusWithCoalitions) {
        if (cursusWithCoalitions.isNotEmpty) {
          final cursus = cursusWithCoalitions.first;
          cursus.coalitions.sort((a, b) => b.score.compareTo(a.score));
          return Right(cursus);
        } else {
          return Left(EmptyDataFailure("No coalitions found"));
        }
      },
    );
  }
}
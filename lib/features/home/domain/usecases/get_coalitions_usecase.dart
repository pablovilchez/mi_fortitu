import 'package:dartz/dartz.dart';
import 'package:mi_fortitu/features/home/domain/entities/bloc_entity.dart';

import '../failures.dart';
import '../repositories/home_intra_repository.dart';

class GetCoalitionsUsecase {
  final HomeIntraRepository repository;

  GetCoalitionsUsecase(this.repository);

  Future<Either<HomeFailure, BlocEntity>> call(String campusId) async {
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
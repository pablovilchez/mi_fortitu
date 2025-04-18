import 'package:dartz/dartz.dart';
import 'package:mi_fortitu/features/coalitions_blocs/domain/repositories/coalitions_blocs_repository.dart';

import '../../../home/domain/failures.dart';
import '../../domain/entities/coalitions_blocs_entity.dart';
import '../datasources/coalitions_blocs_datasource.dart';

class CoalitionsBlocsRepositoryImpl extends CoalitionsBlocsRepository {
  final CoalitionsBlocsDatasource datasource;

  CoalitionsBlocsRepositoryImpl(this.datasource);

  @override
  Future<Either<HomeFailure, List<CoalitionsBlocsEntity>>> getCampusCoalitions(String campusId) async {
    final response = await datasource.getCampusBlocs(campusId: campusId);
    return response.fold(
      (exception) => Left(AuthFailure(exception.toString())),
      (campus) => Right(campus.map((model) => model.toEntity()).toList()),
    );
  }
}
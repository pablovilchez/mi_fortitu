import 'package:dartz/dartz.dart';
import 'package:mi_fortitu/features/coalitions_blocs/domain/coalitions_bloc_failure.dart';
import 'package:mi_fortitu/features/coalitions_blocs/domain/repositories/coalitions_blocs_repository.dart';


import '../../domain/entities/coalitions_blocs_entity.dart';
import '../datasources/coalitions_blocs_datasource.dart';

class CoalitionsBlocsRepositoryImpl extends CoalitionsBlocsRepository {
  final CoalitionsBlocsDatasource datasource;

  CoalitionsBlocsRepositoryImpl(this.datasource);

  @override
  Future<Either<CoalitionsBlocFailure, List<CoalitionsBlocsEntity>>> getCampusCoalitions(String campusId) async {
    final response = await datasource.getCampusBlocs(campusId: campusId);
    return response.fold(
      (exception) => Left(DataFailure(exception.toString())),
      (campus) => Right(campus.map((model) => model.toEntity()).toList()),
    );
  }
}
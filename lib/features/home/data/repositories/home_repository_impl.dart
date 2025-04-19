import 'package:dartz/dartz.dart';
import '../datasources/home_datasource.dart';
import '../../domain/home_failure.dart';
import '../../domain/repositories/home_repository.dart';

import '../../domain/entities/event_entity.dart';


class HomeRepositoryImpl implements HomeRepository {
  final HomeDatasource datasource;

  HomeRepositoryImpl(this.datasource);

  @override
  Future<Either<HomeFailure, List<EventEntity>>> getUserEvents(String loginName) async {
    final response = await datasource.getUserEvents(loginName: loginName);
    return response.fold(
      (exception) => Left(DataFailure(exception.toString())),
      (events) => Right(events.map((model) => model.toEntity()).toList()),
    );
  }

  @override
  Future<Either<HomeFailure, List<EventEntity>>> getCampusEvents(String campusId) async {
    final response = await datasource.getCampusEvents(campusId: campusId);
    return response.fold(
      (exception) => Left(DataFailure(exception.toString())),
      (events) => Right(events.map((model) => model.toEntity()).toList()),
    );
  }
}

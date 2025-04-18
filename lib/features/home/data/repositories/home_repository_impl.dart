import 'package:dartz/dartz.dart';
import 'package:mi_fortitu/features/home/data/datasources/home_datasource.dart';
import 'package:mi_fortitu/features/home/domain/failures.dart';
import 'package:mi_fortitu/features/home/domain/repositories/home_repository.dart';

import '../../domain/entities/event_entity.dart';


class HomeRepositoryImpl implements HomeRepository {
  final HomeDatasource datasource;

  HomeRepositoryImpl(this.datasource);

  @override
  Future<Either<HomeFailure, List<EventEntity>>> getIntraUserEvents(String loginName) async {
    final response = await datasource.getUserEvents(loginName: loginName);
    return response.fold(
      (exception) => Left(AuthFailure(exception.toString())),
      (events) => Right(events.map((model) => model.toEntity()).toList()),
    );
  }

  @override
  Future<Either<HomeFailure, List<EventEntity>>> getIntraCampusEvents(String campusId) async {
    final response = await datasource.getCampusEvents(campusId: campusId);
    return response.fold(
      (exception) => Left(AuthFailure(exception.toString())),
      (events) => Right(events.map((model) => model.toEntity()).toList()),
    );
  }
}

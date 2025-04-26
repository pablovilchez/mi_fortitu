import 'package:dartz/dartz.dart';
import 'package:mi_fortitu/features/profiles/presentation/blocs/user_profile_bloc/user_profile_bloc.dart';
import '../../domain/entities/reg_event_data_entity.dart';
import '../datasources/home_datasource.dart';
import '../../domain/home_failure.dart';
import '../../domain/repositories/home_repository.dart';

import '../../domain/entities/event_entity.dart';


class HomeRepositoryImpl implements HomeRepository {
  final HomeDatasource datasource;

  HomeRepositoryImpl(this.datasource);

  @override
  Future<Either<HomeFailure, List<RegEventDataEntity>>> getUserEvents(String loginName) async {
    final response = await datasource.getUserEvents(loginName: loginName);
    return response.fold(
      (exception) => Left(DataFailure(exception.toString())),
      (events) => Right(events.map((model) => model.toEntity()).toList()),
    );
  }

  @override
  Future<Either<HomeFailure, List<EventEntity>>> getCampusEvents(int campusId) async {
    final response = await datasource.getCampusEvents(campusId: campusId);
    return response.fold(
      (exception) => Left(DataFailure(exception.toString())),
      (events) => Right(events.map((model) => model.toEntity()).toList()),
    );
  }

  @override
  Future<Either<HomeFailure, RegEventDataEntity>> subscribeToEvent({required int userId, required int eventId}) async {
    final response = await datasource.subscribeToEvent(userId: userId, eventId: eventId);
    return response.fold(
      (exception) => Left(DataFailure(exception.toString())),
      (result) => Right(result.toEntity()),
    );
  }

  @override
  Future<Either<HomeFailure, Unit>> unsubscribeFromEvent({required int eventUserId}) async {
    final response = await datasource.unsubscribeFromEvent(eventUserId: eventUserId);
    return response.fold(
      (exception) => Left(DataFailure(exception.toString())),
      (result) => Right(result),
    );
  }
}

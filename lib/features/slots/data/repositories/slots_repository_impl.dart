import 'package:dartz/dartz.dart';

import '../../domain/entities/slot_entity.dart';
import '../../domain/repositories/slots_repository.dart';
import '../../domain/slots_failure.dart';
import '../datasources/slots_datasource.dart';

class SlotsRepositoryImpl implements SlotsRepository {
  final SlotsDatasource datasource;

  SlotsRepositoryImpl(this.datasource,);

  @override
  Future<Either<SlotsFailure, List<SlotEntity>>> getUserOpenSlots() async {
    final response = await datasource.getUserOpenSlots();
    return response.fold(
      (exception) => Left(SlotsFailure(exception.toString())),
      (slots) => Right(slots.map((model) => model.toEntity()).toList()),
    );
  }

  @override
  Future<Either<SlotsFailure, Unit>> createNewSlot(int userId, DateTime begin, DateTime end) async {
    final response = await datasource.createNewSlot(userId, begin, end);
    return response.leftMap((exception) => SlotsFailure(exception.toString()));
  }

  @override
  Future<Either<SlotsFailure, Unit>> destroySlot(int slotId) async {
    final response = await datasource.destroyEvaluationSlot(slotId);
    return response.leftMap((exception) => SlotsFailure(exception.toString()));
  }

  @override
  Future<Either<SlotsFailure, Unit>> destroySlotsWithScaleTeam(int scaleTeamId) async {
    final response = await datasource.destroySlotsWithScaleTeam(scaleTeamId);
    return response.leftMap((exception) => SlotsFailure(exception.toString()));
  }
}

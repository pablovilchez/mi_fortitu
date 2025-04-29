import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import '../../../../core/services/intra_api_client.dart';
import '../models/slot_model.dart';
import '../slots_exception.dart';

class SlotsDatasource {
  final http.Client httpClient;
  final IntraApiClient intraApiClient;

  SlotsDatasource(this.httpClient, this.intraApiClient);

  Future<Either<Exception, List<SlotModel>>> getUserOpenSlots() async {
    final response = await intraApiClient.getUserSlots('me');

    return response.fold(
      (exception) => Left(exception),
      (data) {
        try {
          final slots = data.map((slot) => SlotModel.fromJson(slot)).toList();

          return Right(slots);
        } catch (e) {
          return Left(SlotsException(code: 'S01', details: e.toString()));
        }
      },
    );
  }

  Future<Either<Exception, Unit>> createNewSlot(int userId, DateTime begin, DateTime end) async {
    final response = await intraApiClient.createEvaluationSlot(userId: userId, begin: begin, end: end);
    return response.map((r) => unit);
  }

  Future<Either<Exception, Unit>> destroyEvaluationSlot(int slotId) async {
    final response = await intraApiClient.destroyEvaluationSlot(slotId);
    return response.map((r) => unit);
  }

  Future<Either<Exception, Unit>> destroySlotsWithScaleTeam(int scaleTeamId) async {
    final response = await intraApiClient.destroySlotsWithScaleTeam(scaleTeamId);
    return response.map((r) => unit);

  }
}

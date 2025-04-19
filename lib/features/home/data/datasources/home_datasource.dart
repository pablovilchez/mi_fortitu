import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:mi_fortitu/core/services/intra_api_client.dart';

import '../home_exception.dart';
import '../models/event_model.dart';

class HomeDatasource {
  final http.Client httpClient;
  final IntraApiClient intraApiClient;

  HomeDatasource(this.httpClient, this.intraApiClient);

  Future<Either<HomeException, List<EventModel>>> getUserEvents({required String loginName}) async {
    final userEvents = await intraApiClient.getUserEvents(loginName);
    return userEvents.fold((e) => Left(HomeException(code: 'H00', details: e.toString())), (data) {
      try {
        final events =
            (data).map((event) {
              return EventModel.fromJson(event as Map<String, dynamic>);
            }).toList();
        return Right(events);
      } catch (e) {
        return Left(HomeException(code: 'H01', details: e.toString()));
      }
    });
  }

  Future<Either<HomeException, List<EventModel>>> getCampusEvents({required String campusId}) async {
    final campusEvents = await intraApiClient.getCampusEvents(campusId);
    return campusEvents.fold((e) => Left(HomeException(code: 'H00', details: e.toString())), (
      data,
    ) {
      try {
        final events =
            (data).map((event) {
              return EventModel.fromJson(event as Map<String, dynamic>);
            }).toList();
        return Right(events);
      } catch (e) {
        return Left(HomeException(code: 'H02', details: e.toString()));
      }
    });
  }
}

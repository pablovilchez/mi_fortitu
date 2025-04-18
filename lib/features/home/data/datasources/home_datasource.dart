import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:mi_fortitu/core/services/intra_api_client.dart';
import 'package:mi_fortitu/features/home/data/exceptions.dart';

import '../models/event_model.dart';

class HomeDatasource {
  final http.Client httpClient;
  final IntraApiClient intraApiClient;

  HomeDatasource(this.httpClient, this.intraApiClient);

  Future<Either<Exception, List<EventModel>>> getUserEvents({
    required String loginName,
  }) async {
    final userEvents = await intraApiClient.getUserEvents(loginName);
    return userEvents.fold((exception) => Left(exception), (data) {
      try {
        final events =
            (data).map((event) {
              return EventModel.fromJson(event as Map<String, dynamic>);
            }).toList();
        return Right(events);
      } catch (e) {
        return Left(DataException(message: 'Exception parsing User Events: ${e.toString()}'));
      }
    });
  }

  Future<Either<Exception, List<EventModel>>> getCampusEvents({
    required String campusId,
  }) async {
    final campusEvents = await intraApiClient.getCampusEvents(campusId);
    return campusEvents.fold((exception) => Left(exception), (data) {
      try {
        final events =
            (data).map((event) {
              return EventModel.fromJson(event as Map<String, dynamic>);
            }).toList();
        return Right(events);
      } catch (e) {
        return Left(DataException(message: 'Exception parsing Campus Events: ${e.toString()}'));
      }
    });
  }
}

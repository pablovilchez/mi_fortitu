import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:mi_fortitu/core/services/intra_api_client.dart';

import '../home_exception.dart';
import '../models/event_model.dart';
import '../models/reg_event_data_model.dart';

class HomeDatasource {
  final http.Client httpClient;
  final IntraApiClient intraApiClient;

  HomeDatasource(this.httpClient, this.intraApiClient);

  Future<Either<HomeException, List<RegEventDataModel>>> getUserEvents({required String loginName}) async {
    final userEvents = await intraApiClient.getUserEvents(loginName);
    return userEvents.fold((e) => Left(HomeException(code: 'H00', details: e.toString())), (data) {
      try {
        final events =
            (data).map((event) {
              return RegEventDataModel.fromJson(event as Map<String, dynamic>);
            }).toList();
        return Right(events);
      } catch (e) {
        return Left(HomeException(code: 'H01', details: e.toString()));
      }
    });
  }

  Future<Either<HomeException, List<EventModel>>> getCampusEvents({required int campusId}) async {
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

  Future<Either<HomeException, RegEventDataModel>> subscribeToEvent({required int userId, required int eventId}) async {
    final result = await intraApiClient.subscribeToEvent(userId: userId, eventId: eventId);
    return result.fold((e) => Left(HomeException(code: 'H00', details: e.toString())), (data) {
      try {
        return Right(RegEventDataModel.fromJson(data as Map<String, dynamic>));
      } catch (e) {
        return Left(HomeException(code: 'H03', details: e.toString()));
      }
    });
  }

  Future<Either<HomeException, Unit>> unsubscribeFromEvent({required int eventUserId}) async {
    final result = await intraApiClient.unsubscribeFromEvent(eventUserId);
    return result.fold((e) => Left(HomeException(code: 'H00', details: e.toString())), (data) {
      try {
        return Right(data);
      } catch (e) {
        return Left(HomeException(code: 'H04', details: e.toString()));
      }
    });
  }
}

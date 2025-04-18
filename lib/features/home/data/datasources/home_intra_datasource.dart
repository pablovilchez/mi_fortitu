import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:mi_fortitu/core/services/intra_api_client.dart';
import 'package:mi_fortitu/features/home/data/exceptions.dart';
import 'package:mi_fortitu/features/home/data/models/models.dart';


class HomeIntraDatasource {
  final http.Client httpClient;
  final IntraApiClient intraApiClient;

  HomeIntraDatasource({required this.httpClient, required this.intraApiClient});

  Future<Either<Exception, UserModel>> getUser({required String loginName}) async {
    final user = await intraApiClient.getUser(loginName);
    return user.fold((exception) => Left(exception), (data) {
      try {
        final userModel = UserModel.fromJson(data);
        return Right(userModel);
      } catch (e) {
        return Left(DataException(message: 'Exception parsing User: ${e.toString()}'));
      }
    });
  }

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

  Future<Either<Exception, List<LocationModel>>> getCampusLocations({
    required String campusId,
  }) async {
    final campusLocations = await intraApiClient.getCampusLocations(campusId);
    return campusLocations.fold((exception) => Left(exception), (data) {
      try {
        print('DEBUG     before parsing locations $data');
        final locations =
            (data).map((location) {
              return LocationModel.fromJson(location);
            }).toList();
        print('DEBUG     after parsing locations');
        return Right(locations);
      } catch (e) {
        return Left(DataException(message: 'Exception parsing Locations: ${e.toString()}'));
      }
    });
  }

  Future<Either<Exception, List<BlocModel>>> getCampusBlocs({
    required String campusId,
  }) async {
    final campusBlocs = await intraApiClient.getCampusBlocs(campusId);
    return campusBlocs.fold((exception) => Left(exception), (data) {
      try {
        final blocs =
            (data).map((coalition) {
              return BlocModel.fromJson(coalition as Map<String, dynamic>);
            }).toList();
        return Right(blocs);
      } catch (e) {
        return Left(DataException(message: 'Exception parsing Blocs ${e.toString()}'));
      }
    });
  }

  Future<Either<Exception, List<ProjectUserModel>>> getProjectUsers({
    required String projectId,
    required String campusId,
  }) async {
    final projectUsers = await intraApiClient.getProjectUsers(projectId, campusId);
    return projectUsers.fold((exception) => Left(exception), (data) {
      try {
        final projectUsers =
            (data).map((user) {
              return ProjectUserModel.fromJson(user as Map<String, dynamic>);
            }).toList();
        return Right(projectUsers);
      } catch (e) {
        return Left(DataException(message: 'Exception parsing Project Users: ${e.toString()}'));
      }
    });
  }
}

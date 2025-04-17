import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:mi_fortitu/core/services/intra_api_service.dart';
import 'package:mi_fortitu/features/home/data/models/cluster_user_model.dart';
import 'package:mi_fortitu/features/home/data/models/intra_event_model.dart';
import 'package:mi_fortitu/features/home/data/models/intra_profile_model.dart';

import '../exceptions.dart';
import '../models/cursus_coalitions_model.dart';
import '../models/project_user_model.dart';

class HomeIntraDatasource {
  final http.Client httpClient;
  final IntraApiService intraApiService;

  HomeIntraDatasource({required this.httpClient, required this.intraApiService});

  Future<Either<HomeException, dynamic>> _makeRequest(String route) async {
    final grantToken = await intraApiService.getGrantedToken();
    if (grantToken.isLeft()) {
      return Left(AuthException(code: '01', message: grantToken.fold((l) => l.toString(), (r) => '')));
    }
    final accessToken = grantToken.fold((l) => '', (r) => r);
    try {
      final response = await httpClient.get(
        Uri.parse(route),
        headers: {'Authorization': 'Bearer $accessToken'},
      );
      if (response.statusCode != 200) {
        return Left(RequestException(code: '01', message: '${response.statusCode}: ${response.body}'));
      }
      return Right(jsonDecode(response.body));
    } catch (e) {
      return Left(RequestException(code: '02', message: e.toString()));
    }
  }

  Future<Either<HomeException, IntraProfileModel>> getIntraProfile({
    required String loginName,
  }) async {
    late final String route;
    loginName == 'me'
        ? route = 'https://api.intra.42.fr/v2/me'
        : route = 'https://api.intra.42.fr/v2/users/$loginName';
    final result = await _makeRequest(route);
    return result.fold((exception) => Left(exception), (data) {
      try {
        return Right(IntraProfileModel.fromJson(data as Map<String, dynamic>));
      } catch (e) {
        return Left(DataException(message: '(profile) ${e.toString()}'));
      }
    });
  }

  Future<Either<HomeException, List<IntraEventModel>>> getIntraUserEvents({
    required String loginName,
  }) async {
    final route = 'https://api.intra.42.fr/v2/users/$loginName/events_users';
    final response = await _makeRequest(route);
    return response.fold((exception) => Left(exception), (data) {
      try {
        final events =
            (data as List)
                .map((event) => IntraEventModel.fromJson(event['event'] as Map<String, dynamic>))
                .toList();
        return Right(events);
      } catch (e) {
        return Left(DataException(message: '(user events) ${e.toString()}'));
      }
    });
  }

  Future<Either<HomeException, List<IntraEventModel>>> getIntraCampusEvents({
    required String campusId,
  }) async {
    final route = 'https://api.intra.42.fr/v2/campus/$campusId/events';
    final response = await _makeRequest(route);
    return response.fold((exception) => Left(exception), (data) {
      try {
        final events =
            (data as List)
                .map((event) => IntraEventModel.fromJson(event as Map<String, dynamic>))
                .toList();
        return Right(events);
      } catch (e) {
        return Left(DataException(message: '(campus events) ${e.toString()}'));
      }
    });
  }

  Future<Either<HomeException, List<ClusterUserModel>>> getIntraClusterUsers({
    required String campusId,
  }) async {
    final baseRoute = 'https://api.intra.42.fr/v2/campus/$campusId/locations';
    const int pageSize = 100;
    int pageNumber = 1;
    List<ClusterUserModel> allUsers = [];

    while (true) {
      final filters = '?filter[active]=true&page[size]=$pageSize&page[number]=$pageNumber';
      final response = await _makeRequest(baseRoute + filters);
      if (response.isLeft()) {
        return Left(response.fold((exception) => exception, (r) => r));
      }
      final data = response.fold((l) => l, (r) => r);
      if (data.isEmpty) {
        break;
      }
      try {
        final users =
            (data as List)
                .map((user) => ClusterUserModel.fromJson(user as Map<String, dynamic>))
                .toList();
        allUsers.addAll(users);
        pageNumber++;
      } catch (e) {
        return Left(DataException(message: '(clusters) ${e.toString()}'));
      }
    }
    return Right(allUsers);
  }

  Future<Either<HomeException, List<CursusCoalitionsModel>>> getIntraCampusCoalitions({
    required String campusId,
  }) async {
    final route = 'https://api.intra.42.fr/v2/blocs/?filter[campus_id]=$campusId';
    final response = await _makeRequest(route);
    return response.fold((exception) => Left(exception), (data) {
      try {
        final cursusCoalitions =
            (data as List)
                .map((coalition) => CursusCoalitionsModel.fromJson(coalition as Map<String, dynamic>))
                .toList();
        return Right(cursusCoalitions);
      } catch (e) {
        return Left(DataException(message: '(coalition) ${e.toString()}'));
      }
    });
  }

  Future<Either<HomeException, List<ProjectUserModel>>> getIntraProjectUsers({
    required String projectId, required String campusId,
  }) async {
    final route = 'https://api.intra.42.fr/v2/projects/$projectId/project_users?filter[campus]=$campusId&filter[status]=in_progress&filter[marked]=false';
    final response = await _makeRequest(route);
    return response.fold((exception) => Left(exception), (data) {
      try {
        final projectUsers =
            (data as List)
                .map((user) => ProjectUserModel.fromJson(user as Map<String, dynamic>))
                .toList();
        return Right(projectUsers);
      } catch (e) {
        return Left(DataException(message: '(project users) ${e.toString()}'));
      }
    });
  }
}

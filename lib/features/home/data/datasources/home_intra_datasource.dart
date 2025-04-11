import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:mi_fortitu/core/services/intra_api_service.dart';
import 'package:mi_fortitu/features/home/data/models/cluster_user_model.dart';
import 'package:mi_fortitu/features/home/data/models/intra_event_model.dart';
import 'package:mi_fortitu/features/home/data/models/intra_profile_model.dart';

import '../exceptions.dart';

class HomeIntraDatasource {
  final http.Client httpClient;
  final IntraApiService intraApiService;

  HomeIntraDatasource({required this.httpClient, required this.intraApiService});

  Future<Either<RequestException, dynamic>> _makeRequest(String route) async {
    final grantToken = await intraApiService.getGrantedToken();
    if (grantToken.isLeft()) {
      return Left(TokenException(code: 'E001'));
    }
    final accessToken = grantToken.fold((l) => '', (r) => r);
    try {
      final response = await httpClient.get(
        Uri.parse(route),
        headers: {'Authorization': 'Bearer $accessToken'},
      );
      if (response.statusCode != 200) {
        return Left(CodeException(code: 'E001', message: response.body));
      }
      return Right(jsonDecode(response.body));
    } catch (e) {
      return Left(DataException(code: 'E001', message: e.toString()));
    }
  }

  Future<Either<RequestException, IntraProfileModel>> getIntraProfile({
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
        return Left(DataException(code: 'E002', message: e.toString()));
      }
    });
  }

  Future<Either<RequestException, List<IntraEventModel>>> getIntraUserEvents({
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
        return Left(DataException(code: 'E003', message: e.toString()));
      }
    });
  }

  Future<Either<RequestException, List<IntraEventModel>>> getIntraCampusEvents({
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
        return Left(DataException(code: 'E004', message: e.toString()));
      }
    });
  }

  Future<Either<RequestException, List<ClusterUserModel>>> getIntraClusterUsers({
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
        return Left(DataException(code: 'E005', message: e.toString()));
      }
    }
    return Right(allUsers);
  }
}

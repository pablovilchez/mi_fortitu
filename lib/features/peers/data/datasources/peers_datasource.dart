import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import '../../../../core/services/intra_api_client.dart';
import '../../../home/data/exceptions.dart';
import '../../../profiles/data/models/project_user_model.dart';

class PeersDatasource {
  final http.Client httpClient;
  final IntraApiClient intraApiClient;

  PeersDatasource(this.httpClient, this.intraApiClient);

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
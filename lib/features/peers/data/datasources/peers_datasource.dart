import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import '../../../../core/services/intra_api_client.dart';
import '../models/peer_model.dart';
import '../peers_exception.dart';

class PeersDatasource {
  final http.Client httpClient;
  final IntraApiClient intraApiClient;

  PeersDatasource(this.httpClient, this.intraApiClient);

  Future<Either<Exception, List<PeerModel>>> getProjectUsers({
    required int projectId,
    required int campusId,
  }) async {
    final projectUsers = await intraApiClient.getProjectUsers(projectId, campusId);
    return projectUsers.fold((exception) => Left(exception), (userList) {
      try {
        final peers = userList.map((user) => PeerModel.fromJson(user)).toList();
        return Right(peers);
      } catch (e) {
        return Left(PeersException(code: 'P01', details: e.toString()));
      }
    });
  }
}

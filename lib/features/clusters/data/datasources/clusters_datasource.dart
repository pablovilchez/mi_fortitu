import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:mi_fortitu/core/services/intra_api_client.dart';

import '../clusters_exception.dart';
import '../models/location_model.dart';

/// ClustersDatasource is responsible for fetching data related to clusters
/// from the Intra API.
class ClustersDatasource {
  final http.Client httpClient;
  final IntraApiClient intraApiClient;

  ClustersDatasource(this.httpClient, this.intraApiClient);

  /// Fetches the list of clusters from the Intra API.
  Future<Either<ClustersException, List<LocationModel>>> getCampusLocations({
    required String campusId,
  }) async {
    final campusLocations = await intraApiClient.getCampusLocations(campusId);
    return campusLocations.fold((e) => Left(ClustersException(code: 'C00', details: e.toString())), (data) {
      try {
        final locations = (data).map((location) => LocationModel.fromJson(location)).toList();
        return Right(locations);
      } catch (e) {
        return Left(ClustersException(code: 'C01', details: e.toString()));
      }
    });
  }
}
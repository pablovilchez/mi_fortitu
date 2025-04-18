import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:mi_fortitu/core/services/intra_api_client.dart';

import '../../../home/data/exceptions.dart';
import '../models/location_model.dart';

class ClustersDatasource {
  final http.Client httpClient;
  final IntraApiClient intraApiClient;

  ClustersDatasource(this.httpClient, this.intraApiClient);

  Future<Either<Exception, List<LocationModel>>> getCampusLocations({
    required String campusId,
  }) async {
    final campusLocations = await intraApiClient.getCampusLocations(campusId);
    return campusLocations.fold((exception) => Left(exception), (data) {
      try {
        final locations =
        (data).map((location) {
          return LocationModel.fromJson(location);
        }).toList();
        return Right(locations);
      } catch (e) {
        return Left(DataException(message: 'Exception parsing Locations: ${e.toString()}'));
      }
    });
  }
}
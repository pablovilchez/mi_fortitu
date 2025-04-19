import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import '../../../../core/services/intra_api_client.dart';
import '../coalitions_bloc_exception.dart';
import '../models/coalitions_blocs_model.dart';

class CoalitionsBlocsDatasource {
  final http.Client httpClient;
  final IntraApiClient intraApiClient;

  CoalitionsBlocsDatasource(this.httpClient, this.intraApiClient);

  Future<Either<Exception, List<CoalitionsBlocsModel>>> getCampusBlocs({
    required String campusId,
  }) async {
    final campusBlocs = await intraApiClient.getCampusBlocs(campusId);
    return campusBlocs.fold((exception) => Left(exception), (data) {
      try {
        final blocs =
        (data).map((coalition) {
          return CoalitionsBlocsModel.fromJson(coalition as Map<String, dynamic>);
        }).toList();
        return Right(blocs);
      } catch (e) {
        return Left(CoalitionsBlocException(code: 'C01', details: e.toString()));
      }
    });
  }
}
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import '../../../../core/services/intra_api_client.dart';
import '../../../home/data/exceptions.dart';
import '../models/user_model.dart';

class ProfilesDatasource {
  final http.Client httpClient;
  final IntraApiClient intraApiClient;

  ProfilesDatasource(this.httpClient, this.intraApiClient);

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
}
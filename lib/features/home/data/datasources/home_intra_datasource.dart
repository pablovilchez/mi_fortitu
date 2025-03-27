// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:oauth2/oauth2.dart' as oauth2;
//
// import '../../../../core/utils/secure_storage_helper.dart';
//
// class HomeIntraDatasource {
//   final oauth2.Client dio = oauth2.Client(
//     'https://api.intra.42.fr/v2',
//     identifier: dotenv.env['INTRA_CLIENT_ID'],
//     secret: dotenv.env['INTRA_CLIENT_SECRET'],
//     redirectUri: dotenv.env['INTRA_REDIRECT_URI'],
//   );
//
//   Future<Response> getIntraProfile(String auth) async {
//     final route = '/users/$auth';
//     final bearerToken = await SecureStorageHelper.getIntraAccessToken();
//     if (bearerToken == null) {
//       throw Exception('No token found');
//     }
//     return await dio.get('${dotenv.env['API_BASE_URL']}$route');
//   }
//
//   Future<Response> getIntraUserEvents(String auth) async {
//     final route = '/users/$auth/events';
//     final bearerToken = await SecureStorageHelper.getIntraAccessToken();
//     if (bearerToken == null) {
//       throw Exception('No token found');
//     }
//     return await dio.get(
//       '${dotenv.env['API_BASE_URL']}$route',
//
//     );
//   }
//
//   Future<Response> getIntraCampusEvents() async {
//     final route = '/events';
//     final bearerToken = await SecureStorageHelper.getIntraAccessToken();
//     if (bearerToken == null) {
//       throw Exception('No token found');
//     }
//     return await dio.get('${dotenv.env['API_BASE_URL']}$route');
//   }
// }

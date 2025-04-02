import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mi_fortitu/core/services/intra_api_service.dart';

class HomeIntraDatasource {
  final http.Client httpClient;
  final IntraApiService intraApiService;

  HomeIntraDatasource({required this.httpClient, required this.intraApiService});

  Future<Map<String, dynamic>> _makeGetRequest(String route) async {
    final tokenResult = await intraApiService.getGrantedToken();
    if (tokenResult.isLeft()) {
      final errorMessage = tokenResult.fold((l) => l.message, (r) => null);
      throw Exception('Error getting token: $errorMessage');
    }
    final accessToken = tokenResult.fold((l) => null, (r) => r);
    final response = await httpClient.get(
      Uri.parse(route),
      headers: {'Authorization': 'Bearer $accessToken'},
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to get API data: ${response.body}');
    }
    final data = jsonDecode(response.body) as Map<String, dynamic>;
    data['requestTime'] = DateTime.now().toIso8601String();
    return data;
  }

  Future<Map<String, dynamic>> getIntraProfile({required String loginName}) async {
    final route = 'https://api.intra.42.fr/v2/users/$loginName';
    return await _makeGetRequest(route);
  }

  Future<Map<String, dynamic>> getIntraUserEvents({required String loginName}) async {
    final route = 'https://api.intra.42.fr/v2/users/$loginName/events';
    return await _makeGetRequest(route);
  }

  Future<Map<String, dynamic>> getIntraCampusEvents({required String campusId}) async {
    final route = 'https://api.intra.42.fr/v2/$campusId/events';
    return await _makeGetRequest(route);
  }
}

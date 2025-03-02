import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:mi_fortitu/features/home/data/models/intra_profile_model.dart';

class HomeIntraRepository {

  Future<IntraProfileModel> getMockIntraProfile(String loginName) async {
    final String response = await rootBundle.loadString('test/resources/$loginName.json');
    final Map<String, dynamic> data = await jsonDecode(response);
    return IntraProfileModel.fromJson(data);
  }
}

import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:mi_fortitu/features/home/data/models/models.dart';

import '../../domain/entities/intra_event.dart';
import '../../domain/entities/intra_profile.dart';

class HomeIntraRepository {
  Future<IntraProfile> getMockIntraProfile(String loginName) async {
    try {
      final String response = await rootBundle.loadString(
        'test/resources/$loginName.json',
      );
      final Map<String, dynamic> data = await jsonDecode(response);
      return IntraProfileModel.fromJson(data);
    } catch (e) {
      throw Exception('Profile data failure: Data not found.');
    }
  }

  Future<List<IntraEvent>> getMockIntraUserEvents(String loginName) async {
    try {
      final String response = await rootBundle.loadString(
        'test/resources/user_subscribed_events.json',
      );
      final List<dynamic> jsonData = await jsonDecode(response);
      final List<IntraEventModel> events = jsonData
          .map((e) => IntraEventModel.fromJson(e))
          .toList();
      return events.map((model) => model.toEntity()).toList();
    } catch (e) {
      print(e);
      throw ('Events data (user) failure: Data not found.');
    }
  }

  Future<List<IntraEvent>> getMockIntraCampusEvents() async {
    try {
      final String response = await rootBundle.loadString(
        'test/resources/campus_cursus_events.json',
      );
      final List<dynamic> jsonData = await jsonDecode(response);
      final List<IntraEventModel> events = jsonData
          .map((e) => IntraEventModel.fromJson(e))
          .toList();
      return events.map((model) => model.toEntity()).toList();
    } catch (e) {
      print(e);
      throw ('Events data (cursus) failure: Data not found.');
    }
  }
}

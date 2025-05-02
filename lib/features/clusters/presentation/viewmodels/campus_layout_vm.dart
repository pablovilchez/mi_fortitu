import 'dart:convert';

import 'package:flutter/services.dart';

class CampusLayoutVm {
  final int campusId;
  final String campusName;
  final String country;
  final String city;
  final List<ClusterLayout> clusters;

  CampusLayoutVm({
    required this.campusId,
    required this.campusName,
    required this.country,
    required this.city,
    required this.clusters,
  });

  static Future<CampusLayoutVm> fromCampusJson(String campusId) async {
    final String path = 'assets/campus_layouts/$campusId.json';

    try {
      final content = await rootBundle.loadString(path);
      final json = jsonDecode(content);
      return CampusLayoutVm(
        campusId: json['campusId'],
        campusName: json['campusName'],
        country: json['country'],
        city: json['city'],
        clusters: (json['clusters'] as List).map((e) => ClusterLayout.fromJson(e)).toList(),
      );
    } catch (e) {
      return CampusLayoutVm(
        campusId: 0,
        campusName: 'Default',
        country: 'Default',
        city: 'Default',
        clusters: [],
      );
    }
  }
}

class ClusterLayout {
  final String clusterId;
  final String clusterName;
  final List<RowLayout> rows;

  ClusterLayout({required this.clusterId, required this.clusterName, required this.rows});

  factory ClusterLayout.fromJson(Map<String, dynamic> json) {
    return ClusterLayout(
      clusterId: json['clusterId'],
      clusterName: json['clusterName'],
      rows: (json['rows'] as List).map((e) => RowLayout.fromJson(e)).toList(),
    );
  }
}

class RowLayout {
  final String rowId;
  final List<String> stationsId;
  final bool startsUp;

  RowLayout({required this.rowId, required this.stationsId, required this.startsUp});

  factory RowLayout.fromJson(Map<String, dynamic> json) {
    return RowLayout(
      rowId: json['rowId'],
      stationsId: List<String>.from(json['stationsId']),
      startsUp: json['starts'] == 'up',
    );
  }
}

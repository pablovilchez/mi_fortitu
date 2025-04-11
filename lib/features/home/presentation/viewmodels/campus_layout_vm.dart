import 'dart:convert';
import 'dart:io';

class CampusLayoutVm {
  final int id;
  final String name;
  final String country;
  final String city;
  final List<ClusterLayout> clusters;

  CampusLayoutVm({
    required this.id,
    required this.name,
    required this.country,
    required this.city,
    required this.clusters,
  });

  factory CampusLayoutVm.fromCampusJson(String campusId) {
    final String path = 'assets/campus_layouts/$campusId.json';

    Map<String, dynamic> json;

    final file = File(path);
    if (file.existsSync()) {
      json = jsonDecode(file.readAsStringSync());
    } else {
      json = {
        "id": 0,
        "name": "Default",
        "country": "Default",
        "city": "Default",
        "cluster": [
          {
            "name": "c1_default",
            "rows": [
              {
                "value": 0,
                "stations": [0],
                "starts": "down",
              },
            ],
          },
        ],
      };
    }

    return CampusLayoutVm(
      id: json['id'],
      name: json['name'],
      country: json['country'],
      city: json['city'],
      clusters: (json['cluster'] as List).map((e) => ClusterLayout.fromJson(e)).toList(),
    );
  }
}

class ClusterLayout {
  final String name;
  final List<RowLayout> rows;

  ClusterLayout({required this.name, required this.rows});

  factory ClusterLayout.fromJson(Map<String, dynamic> json) {
    return ClusterLayout(
      name: json['name'],
      rows: (json['rows'] as List).map((e) => RowLayout.fromJson(e)).toList(),
    );
  }
}

class RowLayout {
  final int value;
  final List<int> stations;
  final bool startsUp;

  RowLayout({required this.value, required this.stations, required this.startsUp});

  factory RowLayout.fromJson(Map<String, dynamic> json) {
    return RowLayout(
      value: json['value'],
      stations: List<int>.from(json['stations']),
      startsUp: json['starts'] == 'up',
    );
  }
}

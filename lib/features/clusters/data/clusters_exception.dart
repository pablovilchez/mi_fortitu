import 'package:flutter/foundation.dart';

class ClustersException implements Exception {
  final String code;
  late final String title;
  final String details;

  ClustersException({required this.code, this.details = 'no_details'}) {
    if (code == 'C00') {
      title = 'Error fetching data from server';
    } else if (code == 'C01') {
      title = 'Error parsing Locations data';
    } else {
      title = 'Unknown error';
    }

    if (kDebugMode) {
      print('''📛 [Exception]
  Type   : $runtimeType
  Code   : $code
  Title  : $title
  Details: $details
''');
    }
  }

  @override
  String toString() => code;
}

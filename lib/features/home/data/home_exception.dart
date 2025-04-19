import 'package:flutter/foundation.dart';

class HomeException implements Exception {
  final String code;
  late final String title;
  final String details;

  HomeException({required this.code, this.details = 'no_details'}) {
    if (code == 'H00') {
      title = 'Error fetching data from server';
    } else if (code == 'H01') {
      title = 'Error parsing User Events data';
    } else if (code == 'H02') {
      title = 'Error parsing Campus Events data';
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

import 'package:flutter/foundation.dart';

class SlotsException implements Exception {
  final String code;
  late final String title;
  final String details;

  SlotsException({required this.code, this.details = 'no_details'}) {
    if (code == 'S00') {
      title = 'Error fetching slot data from server';
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
  String toString() => '$code: $title\n$details';
}
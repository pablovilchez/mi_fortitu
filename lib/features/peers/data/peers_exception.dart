import 'package:flutter/foundation.dart';

class PeersException implements Exception {
  final String code;
  late final String title;
  final String details;

  PeersException({required this.code, this.details = 'no_details'}) {
    if (code == 'P01') {
      title = 'Error parsing Projects data';
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

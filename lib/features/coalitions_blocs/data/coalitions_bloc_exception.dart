import 'package:flutter/foundation.dart';

class CoalitionsBlocException implements Exception {
  final String code;
  late final String title;
  final String details;

  CoalitionsBlocException({required this.code, this.details = 'no_details'}) {
    if (code == 'C01') {
      title = 'Error parsing Blocs data';
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

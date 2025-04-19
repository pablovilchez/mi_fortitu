import 'package:flutter/foundation.dart';

class AccessException implements Exception {
  final String code;
  final String title;
  final String details;

  AccessException({required this.code, required this.title, required this.details}) {
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
  String toString() => title;
}

class IntraException extends AccessException {
  IntraException({required super.code, super.details = 'no_details'})
    : super(title: _getTitle(code));

  static String _getTitle(String code) {
    if (code == 'AI01') {
      return 'Intra authentication failed. Bad request for authorization URL';
    } else if (code == 'AI02') {
      return 'Intra authentication failed. No data for authorization URL';
    } else if (code == 'AI03') {
      return 'Intra authentication failed. Failed to listen for redirect URL';
    } else if (code == 'AI04') {
      return 'Intra authentication failed. No authorization code in redirect URL';
    } else if (code == 'AI05') {
      return 'Intra authentication failed. Bad request for token exchange';
    } else {
      return 'Intra authentication failed. Unknown error';
    }
  }
}

class DbException extends AccessException {
  DbException({required super.code, super.details = 'no_details'})
  : super(title: _getTitle(code));

  static String _getTitle(String code) {
    if (code == 'AD01') {
      return 'Failed to login to the database';
    } else if (code == 'AD02') {
      return 'Failed to register to the database';
    } else if (code == 'AD03') {
      return 'Failed to check authentication in the database (no session)';
    } else if (code == 'AD04') {
      return 'Failed to check authentication in the database';
    } else if (code == 'AD05') {
      return 'Failed to get role from the database';
    } else if (code == 'AD06') {
      return 'Failed to add profile to the database';
    } else {
      return 'Intra authentication failed. Unknown error';
    }
  }
}

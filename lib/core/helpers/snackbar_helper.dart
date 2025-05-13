import 'package:flutter/material.dart';

/// A helper class to show snack bars in the app.
///
/// This class provides a static method to show a [Snackbar] with customizable message and appearance.
class SnackbarHelper {

  /// Displays a [Snackbar] with a given [message].
  ///
  /// [context] is the build context required to show the snackbar.
  /// [message] is the text to display in the snackbar.
  /// [isError] determines the color of the snackbar: `true`->red, `false`->green.
  static void showSnackbar(BuildContext context, String message, {bool isError = false}) {
    final snackBar = SnackBar(
      content: Text(message, style: const TextStyle(color: Colors.white)),
      backgroundColor: isError ? Colors.red : Colors.green,
      behavior: SnackBarBehavior.floating,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

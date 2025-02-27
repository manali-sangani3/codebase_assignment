import 'package:flutter/material.dart';

class Utils {
  static void showErrorMessage(
      {required BuildContext context, required String message}) {
    final snackBar = SnackBar(
      elevation: 4,
      duration: const Duration(seconds: 5),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.red,
      content: Text(message),
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..clearSnackBars()
      ..showSnackBar(snackBar);
  }
}

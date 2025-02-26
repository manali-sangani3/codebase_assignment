import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Utils {
  /// Returns status if device has internet available.
  ///
  /// Return true if network available otherwise false.
  static Future<bool> isConnected() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    final connectionIndex = connectivityResult.indexWhere((element) =>
        element == ConnectivityResult.mobile ||
        element == ConnectivityResult.wifi);
    return connectionIndex != -1;
  }

  /// Return string date with yyyy-MM-dd format.
  static String getTodayDate() {
    var now = DateTime.now();
    var formatter = DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    return formattedDate;
  }

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

  static bool isEmpty(String? string) {
    return string == null || string.isEmpty;
  }
}

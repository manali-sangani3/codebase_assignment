import 'package:flutter/material.dart';

class AppConstants {
  static GlobalKey<ScaffoldMessengerState> navigatorKey =
      GlobalKey<ScaffoldMessengerState>();

  static GlobalKey<NavigatorState> navigatorRouterKey =
      GlobalKey<NavigatorState>();

  static const multiLineMaxLength = 500;

  static const textFieldMaxLength = 100;

  static const phoneMaxLength = 15;

  /// Page limit for products
  static const paginationPageLimit = 30;
}

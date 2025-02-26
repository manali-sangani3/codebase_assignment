import 'package:flutter_base_project/app/navigation/route_arguments.dart';

abstract class Routes {
  static const String kSplashScreen = "splash";
  static const String kWelcomeScreen = "welcome";
  static const String kUsersScreen = "users";
  static const String kUserDetailScreen = "user-detail";
  static const String kLoginScreen = "login";
  static const String kAbout = "about";
  static const String kChangeLog = "changeLog";
  static const String kDashboard = "dashboard";
  static const String kCart = "cart";
  static const String kProductDetail = "product-detail";
  static const String kOffline = "offline";
  static const String kLanguage = "language";
  static const String kSettings = "settings";
}
abstract class RoutePaths {
  static const String kSplashPath = "/";
  static const String kWelcomePath = "/welcome";
  static const String kUsersPath = "/users";
  static const String kUserDetailPath = "/user-detail:${RouteArguments.userData}";
  static const String kLoginPath = "/login";
  static const String kAboutPath = "/about";
  static const String kChangeLogPath = "/change-log";
  static const String kDashboardPath = "/dashboard";
  static const String kCart = "/cart";
  static const String kOfflinePath = "/offline-path";
  static const String kLanguagePath = "/language";
  static const String kSettingsPath = "/settings";
}

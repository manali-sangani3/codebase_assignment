import 'package:flutter_base_project/app/navigation/route_arguments.dart';

abstract class Routes {
  static const String kSplashScreen = "splash";

  static const String kUsersScreen = "users";
  static const String kUserDetailScreen = "user-detail";

  static const String kOffline = "offline";
}

abstract class RoutePaths {
  static const String kSplashPath = "/";
  static const String kUsersPath = "/users";
  static const String kUserDetailPath =
      "/user-detail:${RouteArguments.userData}";
  static const String kOfflinePath = "/offline-path";
}

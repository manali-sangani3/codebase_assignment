import 'package:flutter/material.dart';
import 'package:flutter_base_project/app/navigation/routes.dart';
import 'package:flutter_base_project/app/ui/screens/user_list/user_list_view.dart';
import 'package:go_router/go_router.dart';

import '../model/user_data_entity.dart';
import '../ui/screens/splash/splash_screen.dart';
import '../ui/screens/user_detail/user_detail_view.dart';

class AppRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    initialLocation: RoutePaths.kSplashPath,
    debugLogDiagnostics: true,
    navigatorKey: _rootNavigatorKey,
    routes: [
      /// Screen : Splash Screen
      GoRoute(
        name: Routes.kSplashScreen,
        path: RoutePaths.kSplashPath,
        builder: (BuildContext context, GoRouterState state) {
          return const SplashScreen();
        },
      ),

      /// Screen : User List Screen
      GoRoute(
        name: Routes.kUsersScreen,
        path: RoutePaths.kUsersPath,
        builder: (BuildContext context, GoRouterState state) {
          return const UserListView();
        },
      ),

      /// Screen : User Detail Screen
      GoRoute(
        name: Routes.kUserDetailScreen,
        path: RoutePaths.kUserDetailPath,
        builder: (BuildContext context, GoRouterState state) {
          final UserData model = state.extra as UserData? ?? UserData();
          return UserDetailView(
            details: model,
          );
        },
      ),
    ],
    errorBuilder: (context, state) => const Center(
      child: Text('Invalid Screen'),
    ),
  );

  // Navigate to specific screen
  static void navigateToScreen(
      {required BuildContext? context,
      required String redirectURL,
      bool isFromNotification = false,
      bool isAppOpened = false}) async {
    int delay800Millis = isFromNotification ? 0 : 800;

    Future.delayed(Duration(milliseconds: delay800Millis), () {
      if (context != null) {
        router.pushNamed(Routes.kSplashScreen);
      }
    });
  }
}

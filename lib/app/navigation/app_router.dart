import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_base_project/app/model/user_entity.dart';
import 'package:flutter_base_project/app/navigation/route_arguments.dart';
import 'package:flutter_base_project/app/navigation/routes.dart';
import 'package:flutter_base_project/app/ui/change_log.dart';
import 'package:flutter_base_project/app/ui/screens/user_list/user_list_view.dart';
import 'package:go_router/go_router.dart';

import '../ui/screens/product_detail/product_detail.screen.dart';
import '../ui/screens/splash/splash_screen.dart';
import '../ui/screens/unknown/invalid_screen.dart';
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
          UserData? model;
          String? modelJson = state.pathParameters[RouteArguments.userData];
          if (modelJson != null) {
            model = UserData.fromJson(jsonDecode(modelJson));
          }
          return UserDetailView(
            details: model ?? UserData(),
          );
        },
      ),

      // // Screen : Product Details
      // GoRoute(
      //     name: Routes.kProductDetail,
      //     path: RoutePaths.kProductDetailPath,
      //     builder: (BuildContext context, GoRouterState state) =>
      //         ProductDetailScreen(
      //           productId: state.pathParameters[RouteArguments.productId] ?? "",
      //         )),
    ],
    errorBuilder: (context, state) => const InvalidScreen(),
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

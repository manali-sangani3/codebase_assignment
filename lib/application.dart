import 'package:flutter/material.dart';
import 'package:flutter_base_project/app/ui/screens/user_detail/cubit/user_detail_cubit.dart';
import 'package:flutter_base_project/app/ui/screens/user_list/cubit/user_list_cubit.dart';
import 'package:flutter_base_project/config/network/app_connectivity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'app/bloc/application_cubit.dart';
import 'app/navigation/app_router.dart';
import 'app/repository/user_repository.dart';
import 'app/ui/screens/splash/cubit/splash_cubit.dart';
import 'config/flavor_config.dart';
import 'config/network/dio_config.dart';

class Application extends StatefulWidget {
  const Application({super.key});

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  final AppConnectivity _connectivity = AppConnectivity.instance;

  @override
  void initState() {
    super.initState();
    _connectivity.initialise();
    _connectivity.myStream.listen((final source) {});
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: setupLocator(),
      builder: (context, _) {
        return MultiBlocProvider(
            providers: [
              BlocProvider(
                  create: (BuildContext context) => ApplicationCubit()),
              BlocProvider(create: (BuildContext context) => SplashCubit()),
              BlocProvider(
                  create: (BuildContext context) =>
                      UserListCubit(repository: GetIt.I<UserRepository>())),
              BlocProvider(create: (BuildContext context) => UserDetailCubit()),
              // BlocProvider(
              //     create: (BuildContext context) => ProductDetailCubit(
              //         repository: GetIt.I<UserRepository>())),
            ],
            child: MaterialApp.router(
              builder: (context, child) {
                final mediaQueryData = MediaQuery.of(context);
                final scale = mediaQueryData.textScaler
                    .clamp(minScaleFactor: 1.0, maxScaleFactor: 1.3);
                return MediaQuery(
                  data: MediaQuery.of(context).copyWith(textScaler: scale),
                  child: child!,
                );
              },
              theme: ThemeData(
                scaffoldBackgroundColor: Colors.white
              ),
              routeInformationParser: AppRouter.router.routeInformationParser,
              routerDelegate: AppRouter.router.routerDelegate,
              routeInformationProvider:
                  AppRouter.router.routeInformationProvider,
              debugShowCheckedModeBanner: false,
              title: FlavorConfig.instance.name,
            ));
      },
    );
  }

  /// Setup locator
  Future<void> setupLocator() async {
    GetIt getIt = GetIt.I;

    getIt.registerSingleton<UserRepository>(UserRepositoryImpl());

    getIt.registerSingleton<DioProvider>(DioProvider());

    /// Initialise dio provider
    getIt<DioProvider>().initialise();
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_base_project/app/ui/screens/user_list/cubit/user_list_cubit.dart';
import 'package:flutter_base_project/config/app_colors.dart';
import 'package:flutter_base_project/config/network/app_connectivity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'app/domain/repository/user_repository.dart';
import 'app/navigation/app_router.dart';
import 'app/ui/screens/splash/cubit/splash_cubit.dart';
import 'config/flavor_config.dart';
import 'config/resources/theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (BuildContext context) => SplashCubit()),
          BlocProvider(
              create: (BuildContext context) =>
                  UserListCubit(repository: GetIt.I<UserRepository>())),
        ],
        child: MaterialApp.router(
          builder: (context, child) {
            return child!;
          },
          theme: buildTheme(Brightness.light),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          routeInformationParser: AppRouter.router.routeInformationParser,
          routerDelegate: AppRouter.router.routerDelegate,
          routeInformationProvider: AppRouter.router.routeInformationProvider,
          debugShowCheckedModeBanner: false,
          title: FlavorConfig.instance.name,
        ));
  }
}

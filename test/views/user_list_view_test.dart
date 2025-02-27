import 'package:flutter/material.dart';
import 'package:flutter_base_project/app/data/repository/user_repository_impl.dart';
import 'package:flutter_base_project/app/domain/repository/user_repository.dart';
import 'package:flutter_base_project/app/model/user_data_entity.dart';
import 'package:flutter_base_project/app/navigation/app_router.dart';
import 'package:flutter_base_project/app/ui/screens/splash/cubit/splash_cubit.dart';
import 'package:flutter_base_project/app/ui/screens/user_list/cubit/user_list_cubit.dart';
import 'package:flutter_base_project/app/ui/screens/user_list/user_list_view.dart';
import 'package:flutter_base_project/config/resources/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

class MockUserRepository extends Mock implements UserRepository {}

class MockUserData {
  static List<UserData> getUsers() {
    return [
      UserData(
          firstName: 'John',
          lastName: 'Doe',
          email: 'john@example.com',
          avatar: ''),
      UserData(
          firstName: 'Jane',
          lastName: 'Smith',
          email: 'jane@example.com',
          avatar: ''),
    ];
  }
}

void main() {
  final getIt = GetIt.instance;

  setUp(() {
    getIt.registerSingleton<UserRepository>(UserRepositoryImpl());
  });

  tearDown(() {
    getIt.reset(); // Clean up after each test
  });
  group('UserListView UI Tests', () {
    Widget testWrapper({required Widget child}) {
      return MultiBlocProvider(
        providers: [
          BlocProvider(create: (BuildContext context) => SplashCubit()),
          BlocProvider(
              create: (BuildContext context) =>
                  UserListCubit(repository: GetIt.I<UserRepository>())),
        ],
        child: MaterialApp.router(
          builder: (context, widget) {
            return Scaffold(body: widget!);
          },
          theme: buildTheme(Brightness.light),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          routeInformationParser: AppRouter.router.routeInformationParser,
          routerDelegate: AppRouter.router.routerDelegate,
          routeInformationProvider: AppRouter.router.routeInformationProvider,
          debugShowCheckedModeBanner: false,
        ),
      );
    }

    testWidgets('UserListView UI test', (WidgetTester tester) async {
      await tester.pumpWidget(testWrapper(child: UserListView()));
      await tester.pumpAndSettle(const Duration(seconds: 2));
      expect(find.text('Users'), findsOneWidget);
      expect(find.byType(AppBar), findsOneWidget);
    });
    testWidgets('Displays search bar', (WidgetTester tester) async {
      await tester.pumpWidget(testWrapper(child: UserListView()));
      await tester.pumpAndSettle(const Duration(seconds: 2));

      expect(find.byType(TextField), findsOneWidget);
      expect(find.byIcon(Icons.search), findsOneWidget);
      expect(find.byIcon(Icons.clear), findsOneWidget);
    });
    testWidgets('Displays refresh button in app bar',
        (WidgetTester tester) async {
      await tester.pumpWidget(testWrapper(child: UserListView()));
      await tester.pumpAndSettle(const Duration(seconds: 2));
      expect(find.byIcon(Icons.refresh), findsOneWidget);
    });
  });
}

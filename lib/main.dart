import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/adapters.dart';

import 'app/data/repository/user_repository_impl.dart';
import 'app/domain/repository/user_repository.dart';
import 'app/model/user_data_entity.dart';
import 'application.dart';
import 'config/flavor_config.dart';
import 'config/network/dio_config.dart';
import 'config/resources/env_assets.dart';

void main() async {
  await dotenv.load(fileName: ".env");

  FlavorConfig(
      flavor: Flavor.eDev,
      color: Colors.black,
      values: FlavorValues(
        baseUrl: dotenv.get(EnvironmentAssets.kBaseURL),
      ));
  // Ensure all services are loaded before app is started
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(UserDataAdapter()); // Register adapter
  await Hive.openBox<List>('usersBox'); // Open Hive Box
  setupLocator();
  runApp(const Application());
}

/// Setup locator
Future<void> setupLocator() async {
  GetIt getIt = GetIt.I;

  getIt.registerSingleton<UserRepository>(UserRepositoryImpl());

  getIt.registerSingleton<DioProvider>(DioProvider());

  /// Initialise dio provider
  getIt<DioProvider>().initialise();
}

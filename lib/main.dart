import 'package:flutter/material.dart';
import 'package:flutter_base_project/config/network/network_constants.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import 'app/model/user_data_entity.dart';
import 'application.dart';
import 'config/flavor_config.dart';
import 'config/resources/env_assets.dart';

void main() async {
  await dotenv.load(fileName: ".env");

  FlavorConfig(
      flavor: Flavor.eQa,
      color: Colors.black,
      values: FlavorValues(
        baseUrl: dotenv.get(EnvironmentAssets.kBaseURL),
      ));
  // Ensure all services are loaded before app is started
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(UserDataAdapter()); // Register adapter
  await Hive.openBox<List>('usersBox'); // Open Hive Box

  runApp(const Application());
}

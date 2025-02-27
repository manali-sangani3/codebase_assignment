import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'application.dart';
import 'config/flavor_config.dart';
import 'config/resources/env_assets.dart';

void main() async {
  await dotenv.load(fileName: ".env");

  FlavorConfig(
      flavor: Flavor.eDev,
      color: Colors.black,
      values: FlavorValues(baseUrl: dotenv.get(EnvironmentAssets.kBaseURL)));

  // Ensure all services are loaded before app is started.
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const Application());
}

import 'package:flutter/material.dart';
import 'package:flutter_base_project/config/resources/env_assets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'application.dart';
import 'config/flavor_config.dart';
import 'config/network/network_constants.dart';

void main() async {
  // await dotenv.load(fileName: ".env");

  FlavorConfig(
      flavor: Flavor.eDev,
      color: Colors.black,
      values: FlavorValues(
        baseUrl: dotenv.get(EnvironmentAssets.kBaseURL, fallback: NetworkConstants.kProduction),
      ));

  // Ensure all services are loaded before app is started.
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const Application());
}

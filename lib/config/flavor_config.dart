import 'package:flutter/material.dart';
import 'package:flutter_base_project/utils/string_utils.dart';

enum Flavor { eDev, eQa, eProduction }

class FlavorValues {
  FlavorValues({required this.baseUrl});

  final String baseUrl;
}

class FlavorConfig {
  final Flavor flavor;
  final String name;
  final Color color;
  final FlavorValues values;
  static FlavorConfig? _instance;

  factory FlavorConfig(
      {required Flavor flavor,
      color = Colors.blue,
      required FlavorValues values}) {
    _instance ??= FlavorConfig._internal(
        flavor, StringUtils.enumName(flavor.toString()), color, values);
    return _instance!;
  }

  FlavorConfig._internal(this.flavor, this.name, this.color, this.values);

  static FlavorConfig get instance {
    return _instance!;
  }

  static bool isProduction() => _instance?.flavor == Flavor.eProduction;

  static bool isDevelopment() => _instance?.flavor == Flavor.eDev;

  static bool isQA() => _instance?.flavor == Flavor.eQa;
}

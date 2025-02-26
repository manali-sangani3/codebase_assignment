import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../config/utils.dart';

class AppPreferences {
  static final AppPreferences _instance = AppPreferences._internal();

  static AppPreferences get instance => _instance;

  factory AppPreferences() => _instance;

  AppPreferences._internal();

  //------------------------- Preference Constants -----------------------------
  static const String keyLanguageCode = "keyLanguageCode";
  static const String keyLoginDetails = "keyLoginDetails";
  static const String keyUserSettingDetails = "keyUserSettingDetails";
  static const String keySystemAttributeData = "keySystemAttributeData";
  static const String keyIsUserClient = "keyIsUserClient";
  static const String keyOnboardDetails = "keyOnboardDetails";
  static const String keyLoginMethod = "keyLoginMethod";
  static const String keyApiToken = "keyApiToken";
  static const String keyUserID = "keyUserID";
  static const String keyIsLoggedIn = "keyIsLoggedIn";
  static const String keyLanguagePref = "languagePrefs";
  static const String keyIsDarkMode = "keyIsDarkMode";

  // Method to set User Role details
  Future<bool> setIsUserClient(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(keyIsUserClient, value);
  }

  //Method to get User Role details
  Future<bool> getIsUserClient() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(keyIsUserClient) ?? false;
  }

  //Method to set User Role details
  Future<void> saveApiToken({String? value}) async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    shared.setString(keyApiToken, value!);
  }

  //Method to get User Role details
  Future<String> getApiToken() async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    return shared.getString(keyApiToken) ?? "";
  }

  Future<void> isLoggedIn({bool? value}) async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    await shared.setBool(keyIsLoggedIn, value!);
    debugPrint('isLoggedIn ::::::::::   $value');
  }

  Future<bool> getIsLoggedIn() async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    return shared.getBool(keyIsLoggedIn) ?? false;
  }

  Future<void> saveUserID({String? value}) async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    shared.setString(keyUserID, value!);
  }

  Future<String> getUserID() async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    return shared.getString(keyUserID) ?? "";
  }

  // Method to get language code
  Future<String?> getLanguageCode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(keyLanguageCode);
  }

  // Method to set language code
  Future<bool> setLanguageCode(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(keyLanguageCode, value);
  }
  //
  // // Method to get login details
  // Future<UserDetailsData?> getLoginDetails() async {
  //   SharedPreferences shared = await SharedPreferences.getInstance();
  //   String? userDetailsData = shared.getString(keyLoginDetails);
  //   if (Utils.isEmpty(userDetailsData)) {
  //     return null;
  //   }
  //   try {
  //     return UserDetailsData.fromJson(json.decode(userDetailsData!));
  //   } catch (e) {
  //     debugPrint("App Preference error: ${e.toString()}");
  //   }
  //   return null;
  // }
  //
  // // Method to set login details
  // Future<bool> setLoginDetails(UserDetailsData userDetailsData) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String loginDetails = json.encode(userDetailsData.toJson());
  //   return prefs.setString(keyLoginDetails, loginDetails);
  // }

  Future<void> clearData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(keyLoginDetails);
    prefs.remove(keyLoginMethod);
  }

  Future<void> clearLangData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(keyLanguagePref);
  }
  // Method to set dark mode
  Future<bool> setIsDarkMode({final bool? value}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(keyIsDarkMode, value ?? false);
  }

  //Method to get dark mode
  Future<bool> getIsDarkMode() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(keyIsDarkMode) ?? false;
  }

}

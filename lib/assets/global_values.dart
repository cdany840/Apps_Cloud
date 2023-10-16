import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GlobalValues {

  static ValueNotifier<bool> flagTheme = ValueNotifier<bool>(true);
  static ValueNotifier<bool> flagTask = ValueNotifier<bool>(true);

  static late SharedPreferences prefsTheme;
  static late SharedPreferences prefsCheck;
  
  static Future<void> configPrefs() async {
    prefsTheme = await SharedPreferences.getInstance();
    prefsCheck = await SharedPreferences.getInstance();
  }

  // Future<bool> getThemePreference() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   return prefs.getBool('flagTheme') ?? false; // Valor predeterminado si no se encuentra
  // }
  
}

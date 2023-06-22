import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

///
/// Storage Manager for app
class AppStorageManager {
  static AppStorageManager? _instance;
  AppStorageManager._();
  static AppStorageManager get instance => _instance ??= AppStorageManager._();

  late SharedPreferences prefs;
  final String themeMode = 'themeMode';

  /// initiate
  Future init([SharedPreferences? preferences]) async {
    prefs = preferences ?? await SharedPreferences.getInstance();
  }

  /// toggle theme in cache
  Future<bool> toggleThemeMode(ThemeMode mode) async {
    return await prefs.setString(themeMode, mode.name);
  }

  ThemeMode getThemeMode() {
    final inMemory = prefs.getString(themeMode);
    return ThemeMode.values
        .firstWhere((e) => e.name == inMemory, orElse: () => ThemeMode.system);
  }
}

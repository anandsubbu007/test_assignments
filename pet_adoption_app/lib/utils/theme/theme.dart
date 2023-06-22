import 'package:flutter/material.dart';
import 'package:pet_adoption_app/db/storage_manager.dart';
import 'package:pet_adoption_app/utils/utils.dart';
export 'package:provider/provider.dart';

class ThemeManager with ChangeNotifier {
  ThemeManager() {
    appStorageManager = AppStorageManager.instance;
  }

  static ThemeData lightTheme(BuildContext context) => ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
      useMaterial3: true,
      cardColor: Colors.white,
      canvasColor: creamColor,
      textTheme: Typography().black);

  static ThemeData darkTheme(BuildContext context) {
    final typo = Typography().white;
    return ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 33, 65, 81)),
        useMaterial3: true,
        cardColor: Colors.black,
        canvasColor: Colors.white,
        textTheme: Typography().white.copyWith(
            titleMedium: typo.labelMedium?.copyWith(color: Colors.white60),
            labelMedium: typo.labelMedium?.copyWith(color: Colors.white60))
        // colorSchemeSeed: Colors.white70,
        );
  }

  //Colors
  static Color creamColor = const Color(0xfff5f5f5);
  // static Color darkCreamColor = Colors.white70;

  late AppStorageManager appStorageManager;

  ThemeMode getThemeMode() {
    return appStorageManager.getThemeMode();
  }

  void setTheme(ThemeMode themeMode) {
    appStorageManager.toggleThemeMode(themeMode);
    isDarkMode ? Utils.setDarkStatusBar() : Utils.setLightStatusBar();
    notifyListeners();
  }

  bool get isDarkMode => getThemeMode() == ThemeMode.dark;
}

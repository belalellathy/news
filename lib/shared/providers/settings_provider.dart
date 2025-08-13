import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider with ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;
  Future<void> saveTheme(ThemeMode theme) async {
    final prefs = await SharedPreferences.getInstance();
    switch (theme) {
      case ThemeMode.light:
        await prefs.setString('themeMode', 'light');
        break;
      case ThemeMode.dark:
        await prefs.setString('themeMode', 'dark');
        break;
      default:
        await prefs.setString('themeMode', 'system');
    }
    themeMode = theme;
    notifyListeners();
  }
 Future<void> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final themeString = prefs.getString('themeMode') ?? 'system';
    switch (themeString) {
      case 'light':
        themeMode = ThemeMode.light;
        break;
      case 'dark':
        themeMode = ThemeMode.dark;
        break;
      default:
        themeMode = ThemeMode.system;
    }
    notifyListeners();
  }
  bool get isDark {
    if (themeMode == ThemeMode.system) {
      // Check the system brightness (requires BuildContext)
      final brightness = WidgetsBinding.instance.window.platformBrightness;
      return brightness == Brightness.dark;
    }
    return themeMode == ThemeMode.dark;
  }

  void changetheme(ThemeMode theme) {
    themeMode = theme;
    notifyListeners();
  }
}

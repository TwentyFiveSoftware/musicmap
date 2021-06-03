import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  SettingsProvider() {
    loadThemeMode();
  }

  Future<void> loadThemeMode() async {
    SharedPreferences p = await SharedPreferences.getInstance();
    _themeMode = ThemeMode.values[p.getInt('SETTING_THEME_MODE') ?? 0];
    notifyListeners();
  }

  Future<void> changeThemeMode(ThemeMode newThemeMode) async {
    SharedPreferences p = await SharedPreferences.getInstance();
    p.setInt('SETTING_THEME_MODE', newThemeMode.index);
    _themeMode = newThemeMode;
    notifyListeners();
  }

  ThemeMode get themeMode => _themeMode;
}

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  bool isDarkModeChecked = false;

  void updateMode({required bool darkMode}) async {
    isDarkModeChecked = darkMode;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkModeChecked', darkMode);
    notifyListeners();
  }

  void loadMode() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    isDarkModeChecked = prefs.getBool('isDarkModeChecked') ?? true;
    notifyListeners();
  }
}

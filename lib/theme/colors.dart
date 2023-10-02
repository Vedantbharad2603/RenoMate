import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Theme {
  static late SharedPreferences _prefs;

  // Initialize the _prefs variable
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Color get background => _backgroundColor();
  static get toggleTheme => _toggleTheme();

  static Color _backgroundColor() {
    return (_prefs.getBool("darkMode") ?? false) ? Colors.black : Colors.white;
  }

  static void _toggleTheme() {
    _prefs.setBool('darkMode', !(_prefs.getBool("darkMode") ?? false));
  }
}

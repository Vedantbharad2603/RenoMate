import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyTheme {
  static late SharedPreferences _prefs;

  // Initialize the _prefs variable
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Color get primary => _primaryColor();
  static Color get accent => _accentColor();
  static Color get background => _backgroundColor();
  static Color get backgroundSecondry => _backgroundSecondryColor();
  static Color get cardBackground => _cardBackgroundColor();
  static Color get button1 => _buttonColor1();
  static Color get button2 => _buttonColor2();
  static Color get button3 => _buttonColor3();
  static Color get textFieldBack => _textFieldBackColor();
  static Color get text => _textColor();
  static Color get title => _titleColor();
  static Color get description => _descriptionColor();
  static get toggleTheme => _toggleTheme();

  static Color _primaryColor() {
    return (_prefs.getBool("darkMode") ?? true)
        ? const Color.fromRGBO(5, 250, 0, 1)
        : const Color.fromRGBO(87, 112, 122, 1);
  }

  static Color _accentColor() {
    return (_prefs.getBool("darkMode") ?? true)
        ? const Color.fromRGBO(86, 86, 86, 1)
        : const Color.fromRGBO(118, 152, 157, 1);
  }

  static Color _backgroundColor() {
    return (_prefs.getBool("darkMode") ?? true)
        ? const Color.fromRGBO(0, 0, 0, 1)
        : const Color.fromRGBO(222, 220, 220, 1);
  }

  static Color _backgroundSecondryColor() {
    return (_prefs.getBool("darkMode") ?? true)
        ? const Color.fromRGBO(33, 36, 40, 1)
        : const Color.fromRGBO(222, 220, 220, 1);
  }

  static Color _cardBackgroundColor() {
    return (_prefs.getBool("darkMode") ?? true)
        ? const Color.fromRGBO(118, 118, 118, 1)
        : const Color.fromRGBO(152, 157, 170, 1);
  }

  static Color _buttonColor1() {
    return (_prefs.getBool("darkMode") ?? true)
        ? const Color.fromRGBO(5, 250, 0, 1)
        : const Color.fromRGBO(87, 112, 122, 1);
  }

  static Color _buttonColor2() {
    return (_prefs.getBool("darkMode") ?? true)
        ? const Color.fromRGBO(118, 118, 118, 1)
        : const Color.fromRGBO(152, 157, 170, 1);
  }

  static Color _buttonColor3() {
    return (_prefs.getBool("darkMode") ?? true)
        ? const Color.fromRGBO(118, 118, 118, 1)
        : const Color.fromRGBO(152, 157, 170, 1);
  }

  static Color _textFieldBackColor() {
    return (_prefs.getBool("darkMode") ?? true)
        ? const Color.fromRGBO(33, 36, 40, 1)
        : const Color.fromRGBO(33, 36, 40, 1);
  }

  static Color _textColor() {
    return (_prefs.getBool("darkMode") ?? true)
        ? Colors.white.withOpacity(.9)
        : const Color.fromRGBO(25, 29, 35, 1);
  }

  static Color _titleColor() {
    return (_prefs.getBool("darkMode") ?? true)
        ? Colors.white.withOpacity(.9)
        : const Color.fromRGBO(25, 29, 35, 1);
  }

  static Color _descriptionColor() {
    return (_prefs.getBool("darkMode") ?? true)
        ? const Color.fromRGBO(118, 118, 118, 1)
        : const Color.fromRGBO(152, 157, 170, 1);
  }

  static void _toggleTheme() {
    _prefs.setBool('darkMode', !(_prefs.getBool("darkMode") ?? true));
  }
}

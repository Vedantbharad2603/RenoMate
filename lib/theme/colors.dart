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
  static Color get cardBackground => _cardBackgroundColor();
  static Color get button1 => _buttonColor1();
  static Color get button2 => _buttonColor2();
  static Color get textFieldBack => _textFieldBackColor();
  static Color get text => _textColor();
  static Color get title => _titleColor();
  static Color get description => _descriptionColor();
  static get toggleTheme => _toggleTheme();

  static Color _primaryColor() {
    return (_prefs.getBool("darkMode") ?? true)
        ? const Color.fromARGB(255, 5, 250, 0)
        : const Color.fromARGB(255, 5, 250, 0);
  }

  static Color _accentColor() {
    return (_prefs.getBool("darkMode") ?? true)
        ? const Color.fromRGBO(118, 118, 118, 1)
        : const Color.fromRGBO(118, 118, 118, 1);
  }

  static Color _backgroundColor() {
    return (_prefs.getBool("darkMode") ?? true)
        ? const Color.fromRGBO(41, 44, 49, 1)
        : const Color.fromARGB(255, 255, 255, 255);
  }

  static Color _cardBackgroundColor() {
    return (_prefs.getBool("darkMode") ?? true)
        ? const Color.fromRGBO(118, 118, 118, 1)
        : const Color.fromRGBO(118, 118, 118, 1);
  }

  static Color _buttonColor1() {
    return (_prefs.getBool("darkMode") ?? true)
        ? const Color.fromARGB(255, 5, 250, 0)
        : const Color.fromARGB(255, 5, 250, 0);
  }

  static Color _buttonColor2() {
    return (_prefs.getBool("darkMode") ?? true)
        ? const Color.fromRGBO(118, 118, 118, 1)
        : const Color.fromRGBO(118, 118, 118, 1);
  }

  static Color _textFieldBackColor() {
    return (_prefs.getBool("darkMode") ?? true)
        ? const Color.fromRGBO(33, 36, 40, 1)
        : const Color.fromRGBO(33, 36, 40, 1);
  }
 
  static Color _textColor() {
    return (_prefs.getBool("darkMode") ?? true)
        ? Colors.white.withOpacity(.9)
        : Colors.black.withOpacity(.9);
  }

  static Color _titleColor() {
    return (_prefs.getBool("darkMode") ?? true)
        ? Colors.white.withOpacity(.9)
        : Colors.black.withOpacity(.9);
  }

  static Color _descriptionColor() {
    return (_prefs.getBool("darkMode") ?? true)
        ? const Color.fromRGBO(118, 118, 118, 1)
        : const Color.fromRGBO(118, 118, 118, 1);
  }

  static void _toggleTheme() {
    _prefs.setBool('darkMode', !(_prefs.getBool("darkMode") ?? false));
  }
}

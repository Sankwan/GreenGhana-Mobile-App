import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  final String key = 'theme';
  SharedPreferences? _prefs;
  bool? _darktheme;

  bool? get darkTheme => _darktheme;
  
  ThemeProvider() {
    _darktheme = false;
    _loadFromPrefs();
  }

  toggleTheme() {
    _darktheme = !_darktheme!;
    _saveToPrefs();
    notifyListeners();
  }

  _loadFromPrefs() async {
    await _initPrefs();
    _darktheme = _prefs!.getBool(key) ?? false;
    notifyListeners();
  }

  _saveToPrefs() async {
    await _initPrefs();
    _prefs!.setBool(key, _darktheme!);
  }

  _initPrefs() async {
    _prefs ??= await SharedPreferences.getInstance();
  }
}

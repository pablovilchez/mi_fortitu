import 'dart:ui';

import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  static final PreferencesHelper _instance = PreferencesHelper._internal();

  factory PreferencesHelper() => _instance;

  PreferencesHelper._internal();

  SharedPreferences? _prefs;

  static const List<String> supportedLanguages = ['en', 'es'];

  static const String _keyLanguage = 'language';
  static const String _keyFirstRun = 'first_run';

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> setTheme(bool isDarkMode) async {
    await _prefs?.setBool('isDarkMode', isDarkMode);
  }

  bool getTheme() {
    return _prefs?.getBool('isDarkMode') ?? false;
  }

  String getLanguage() {
    String? savedLanguage = _prefs?.getString(_keyLanguage);
    bool isFirstRun = _prefs?.getBool(_keyFirstRun) ?? true;

    if (isFirstRun) {
      String systemLanguaje = PlatformDispatcher.instance.locale.languageCode;
      String selectedLanguaje =
          supportedLanguages.contains(systemLanguaje) ? systemLanguaje : 'en';

      _prefs?.setString(_keyLanguage, selectedLanguaje);
      _prefs?.setBool(_keyFirstRun, false);
      return selectedLanguaje;
    }
    return savedLanguage ?? 'en';;
  }

  Future<void> setLanguage(String languageCode) async {
    await _prefs?.setString(_keyLanguage, languageCode);
  }
}

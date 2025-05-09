import 'dart:ui';
import 'package:shared_preferences/shared_preferences.dart';

/// A singleton helper class to manage app preferences such as theme and language.
///
/// It uses `SharedPreferences` to persist data across sessions.
class PreferencesHelper {
  static final PreferencesHelper _instance = PreferencesHelper._internal();

  factory PreferencesHelper() => _instance;

  PreferencesHelper._internal();

  SharedPreferences? _prefs;

  static const List<String> supportedLanguages = ['en', 'es'];

  static const String _keyLanguage = 'language';
  static const String _keyFirstRun = 'first_run';

  /// Initializes the [SharedPreferences] instance.
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  /// Stores the user's theme preference.
  ///
  /// [isDarkMode] is `true` for dark theme, `false` for light.
  Future<void> setTheme(bool isDarkMode) async {
    await _prefs?.setBool('isDarkMode', isDarkMode);
  }

  /// Returns the stored theme preference.
  ///
  /// Defaults to `false` (light theme) if unset.
  bool getTheme() {
    return _prefs?.getBool('isDarkMode') ?? false;
  }

  /// Returns the stored language code.
  ///
  /// On the first run, it checks the system locale and saves a supported language.
  /// If unsupported, defaults to `'en'`.
  String getLanguage() {
    String? savedLanguage = _prefs?.getString(_keyLanguage);
    bool isFirstRun = _prefs?.getBool(_keyFirstRun) ?? true;

    if (isFirstRun) {
      String systemLanguage = PlatformDispatcher.instance.locale.languageCode;
      String selectedLanguage =
          supportedLanguages.contains(systemLanguage) ? systemLanguage : 'en';

      _prefs?.setString(_keyLanguage, selectedLanguage);
      _prefs?.setBool(_keyFirstRun, false);
      return selectedLanguage;
    }
    return savedLanguage ?? 'en';
  }

  /// Updates the preferred language code.
  Future<void> setLanguage(String languageCode) async {
    await _prefs?.setString(_keyLanguage, languageCode);
  }
}

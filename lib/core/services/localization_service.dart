import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@singleton
class LocalizationService extends ChangeNotifier {
  static const String _localeKey = 'selected_locale';

  Locale _currentLocale = const Locale('kk'); // Default to Russian

  Locale get currentLocale => _currentLocale;

  // Supported locales
  static const List<Locale> supportedLocales = [
    // Locale('en'),
    Locale('ru'),
    Locale('kk'),
  ];

  // Language names for UI
  static const Map<String, String> languageNames = {
    'en': 'EN',
    'ru': 'RU',
    'kk': 'KZ',
  };

  @PostConstruct()
  Future<void> initialize() async {
    await _loadSavedLocale();
  }

  Future<void> _loadSavedLocale() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedLocale = prefs.getString(_localeKey);

      if (savedLocale != null) {
        _currentLocale = Locale(savedLocale);
        notifyListeners();
      }
    } catch (e) {
      // If loading fails, use default locale
      _currentLocale = const Locale('ru');
    }
  }

  Future<void> changeLocale(Locale newLocale) async {
    if (_currentLocale == newLocale) return;

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_localeKey, newLocale.languageCode);

      _currentLocale = newLocale;
      notifyListeners();
    } catch (e) {
      // Handle error if needed
      rethrow;
    }
  }

  void cycleToNextLanguage() {
    final currentIndex = supportedLocales.indexWhere(
      (locale) => locale.languageCode == _currentLocale.languageCode,
    );

    final nextIndex = (currentIndex + 1) % supportedLocales.length;
    changeLocale(supportedLocales[nextIndex]);

    // Notify about language change for content refresh
    _notifyLanguageChanged();
  }

  void _notifyLanguageChanged() {
    // This will be used by pages/blocs to refresh server content
    // We can expand this later with specific callbacks if needed
    notifyListeners();
  }

  String getCurrentLanguageDisplayName() {
    return languageNames[_currentLocale.languageCode] ?? 'RU';
  }
}
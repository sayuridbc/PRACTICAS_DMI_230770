import 'package:flutter/material.dart';
import 'package:practica_04/core/storage/preferences_storage.dart';
import 'package:practica_04/core/theme/seasonal_theme.dart';

class SeasonalThemeProvider extends ChangeNotifier {
  final PreferencesStorage _storage = PreferencesStorage();
  bool _autoMode = true;
  String _manualThemeId = SeasonalThemes.normal.id;

  bool get autoMode => _autoMode;
  String get manualThemeId => _manualThemeId;

  SeasonalThemeProvider() {
    _load();
  }

  Future<void> _load() async {
    final mode = await _storage.getThemeMode();
    final themeName = await _storage.getThemeName();
    _autoMode = mode == 'auto';
    _manualThemeId = themeName;
    notifyListeners();
  }

  SeasonalThemeConfig get currentTheme {
    if (_autoMode) {
      return _resolveByDate();
    }
    return SeasonalThemes.byId(_manualThemeId);
  }

  Future<void> setAutoMode(bool value) async {
    _autoMode = value;
    await _storage.saveThemeMode(value ? 'auto' : 'manual');
    notifyListeners();
  }

  Future<void> setManualTheme(String themeId) async {
    _manualThemeId = themeId;
    await _storage.saveThemeName(themeId);
    notifyListeners();
  }

  SeasonalThemeConfig _resolveByDate() {
    final now = DateTime.now();
    final isHalloween = now.month == 10 && now.day >= 20 && now.day <= 31;
    final isChristmas = now.month == 12 && now.day >= 15 && now.day <= 31;
    final isValentines = now.month == 2 && now.day >= 7 && now.day <= 15;

    if (isHalloween) return SeasonalThemes.halloween;
    if (isChristmas) return SeasonalThemes.christmas;
    if (isValentines) return SeasonalThemes.valentines;
    return SeasonalThemes.normal;
  }
}

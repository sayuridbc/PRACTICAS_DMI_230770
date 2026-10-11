import 'package:shared_preferences/shared_preferences.dart';

class PreferencesStorage {
  static const String _likedKey = 'liked_videos';
  static const String _favoriteKey = 'favorite_videos';
  static const String _themeModeKey = 'theme_mode';
  static const String _themeNameKey = 'theme_name';

  Future<Set<String>> getLikedVideos() async {
    final prefs = await SharedPreferences.getInstance();
    final items = prefs.getStringList(_likedKey) ?? const <String>[];
    return items.toSet();
  }

  Future<void> saveLikedVideos(Set<String> ids) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_likedKey, ids.toList());
  }

  Future<Set<String>> getFavoriteVideos() async {
    final prefs = await SharedPreferences.getInstance();
    final items = prefs.getStringList(_favoriteKey) ?? const <String>[];
    return items.toSet();
  }

  Future<void> saveFavoriteVideos(Set<String> ids) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_favoriteKey, ids.toList());
  }

  Future<String> getThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_themeModeKey) ?? 'auto';
  }

  Future<void> saveThemeMode(String mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_themeModeKey, mode);
  }

  Future<String> getThemeName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_themeNameKey) ?? 'normal';
  }

  Future<void> saveThemeName(String themeName) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_themeNameKey, themeName);
  }
}

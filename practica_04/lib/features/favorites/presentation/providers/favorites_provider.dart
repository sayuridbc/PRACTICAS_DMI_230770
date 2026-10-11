import 'package:flutter/material.dart';
import 'package:practica_04/core/storage/preferences_storage.dart';

class FavoritesProvider extends ChangeNotifier {
  final PreferencesStorage _storage = PreferencesStorage();
  final Set<String> _favoriteIds = <String>{};

  Set<String> get favoriteIds => Set<String>.from(_favoriteIds);

  FavoritesProvider() {
    _load();
  }

  Future<void> _load() async {
    _favoriteIds
      ..clear()
      ..addAll(await _storage.getFavoriteVideos());
    notifyListeners();
  }

  Future<void> toggle(String id) async {
    if (_favoriteIds.contains(id)) {
      _favoriteIds.remove(id);
    } else {
      _favoriteIds.add(id);
    }
    await _storage.saveFavoriteVideos(_favoriteIds);
    notifyListeners();
  }
}

import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:practica_04/core/storage/preferences_storage.dart';
import 'package:practica_04/features/feed/data/datasources/external_video_data_source.dart';
import 'package:practica_04/features/feed/data/datasources/local_video_data_source.dart';
import 'package:practica_04/features/feed/data/datasources/remote_video_data_source.dart';
import 'package:practica_04/features/feed/data/repositories/video_repository_impl.dart';
import 'package:practica_04/features/feed/domain/entities/video.dart';

class VideoFeedProvider extends ChangeNotifier {
  final PreferencesStorage _storage = PreferencesStorage();
  late final VideoRepositoryImpl _repository;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  List<Video> _videos = [];
  List<Video> get videos => _videos;

  final Set<String> _likedIds = <String>{};
  Set<String> get likedIds => LinkedHashSet<String>.from(_likedIds);

  final Set<String> _favoriteIds = <String>{};
  Set<String> get favoriteIds => LinkedHashSet<String>.from(_favoriteIds);

  VideoFeedProvider() {
    _repository = VideoRepositoryImpl(
      localDataSource: LocalVideoDataSource(),
      remoteDataSource: RemoteVideoDataSource(),
      externalDataSource: ExternalVideoDataSource(),
    );
    _load();
  }

  Future<void> _load() async {
    final allVideos = await _repository.getFeed();
    final liked = await _storage.getLikedVideos();
    final favorites = await _storage.getFavoriteVideos();

    _likedIds
      ..clear()
      ..addAll(liked);

    _favoriteIds
      ..clear()
      ..addAll(favorites);

    _videos = allVideos.map((video) {
      final isLiked = _likedIds.contains(video.id);
      final isFavorite = _favoriteIds.contains(video.id);
      return video.copyWith(isLiked: isLiked, isFavorite: isFavorite);
    }).toList();

    _isLoading = false;
    notifyListeners();
  }

  Future<void> toggleLike(String id) async {
    final index = _videos.indexWhere((item) => item.id == id);
    if (index == -1) return;

    final current = _videos[index];
    final nextLiked = !current.isLiked;
    final nextVideo = current.copyWith(isLiked: nextLiked);
    final baseLikes = current.initialLikes;
    final adjusted = baseLikes + (nextLiked ? 1 : -1);
    final updated = nextVideo.copyWith(initialLikes: adjusted < 0 ? 0 : adjusted);

    _videos[index] = updated;
    if (nextLiked) {
      _likedIds.add(id);
    } else {
      _likedIds.remove(id);
    }
    await _storage.saveLikedVideos(_likedIds);
    notifyListeners();
  }

  Future<void> toggleFavorite(String id) async {
    final index = _videos.indexWhere((item) => item.id == id);
    if (index == -1) return;

    final current = _videos[index];
    final nextFavorite = !current.isFavorite;
    final updated = current.copyWith(isFavorite: nextFavorite);
    _videos[index] = updated;

    if (nextFavorite) {
      _favoriteIds.add(id);
    } else {
      _favoriteIds.remove(id);
    }
    await _storage.saveFavoriteVideos(_favoriteIds);
    notifyListeners();
  }

  List<Video> get favorites => _videos.where((item) => item.isFavorite).toList();
}

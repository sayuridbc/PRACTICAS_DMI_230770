import 'package:practica_04/features/feed/domain/entities/video.dart';

abstract class VideoRepository {
  Future<List<Video>> getFeed();
  Future<List<Video>> getForYou();
  Future<List<Video>> getFavorites(List<String> favoriteIds);
}

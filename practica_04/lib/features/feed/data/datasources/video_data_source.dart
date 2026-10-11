import 'package:practica_04/features/feed/data/models/video_model.dart';

abstract class VideoDataSource {
  Future<List<VideoModel>> loadVideos();
}

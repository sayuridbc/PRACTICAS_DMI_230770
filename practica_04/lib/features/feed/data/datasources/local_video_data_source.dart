import 'package:practica_04/features/feed/data/datasources/video_data_source.dart';
import 'package:practica_04/features/feed/data/models/video_model.dart';
import 'package:practica_04/features/feed/data/catalogs/additional_videos.dart';

class LocalVideoDataSource implements VideoDataSource {
  @override
  Future<List<VideoModel>> loadVideos() async {
    final videos = <VideoModel>[];
    for (final item in additionalVideoCatalog) {
      videos.add(VideoModel.fromJson(item));
    }
    return videos;
  }
}

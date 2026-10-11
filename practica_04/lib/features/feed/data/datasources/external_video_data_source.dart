import 'package:practica_04/features/feed/data/datasources/video_data_source.dart';
import 'package:practica_04/features/feed/data/models/video_model.dart';

class ExternalVideoDataSource implements VideoDataSource {
  @override
  Future<List<VideoModel>> loadVideos() async {
    return [
      VideoModel(
        id: 'external-demo-01',
        title: 'Vimeo-ready demo',
        description: 'This entry models a platform-compatible video source. Replace the URL with your real Vimeo or Dailymotion link when the final content is ready.',
        creator: 'External Platform',
        url: 'https://www.w3schools.com/html/mov_bbb.mp4',
        sourceLabel: 'Vimeo/Dailymotion ready',
        sourceType: 'external',
        initialLikes: 840,
        views: 11600,
        isAvailable: true,
        isDemo: true,
      ),
    ];
  }
}

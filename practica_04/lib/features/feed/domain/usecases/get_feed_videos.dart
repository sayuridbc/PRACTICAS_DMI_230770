import 'package:practica_04/features/feed/domain/entities/video.dart';
import 'package:practica_04/features/feed/domain/repositories/video_repository.dart';

class GetFeedVideos {
  final VideoRepository repository;

  GetFeedVideos(this.repository);

  Future<List<Video>> call() async {
    return repository.getFeed();
  }
}

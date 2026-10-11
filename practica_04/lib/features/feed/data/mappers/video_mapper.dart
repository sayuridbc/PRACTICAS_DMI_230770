import 'package:practica_04/core/constants/video_source_types.dart';
import 'package:practica_04/features/feed/data/models/video_model.dart';
import 'package:practica_04/features/feed/domain/entities/video.dart';

class VideoMapper {
  static Video fromModel(VideoModel model, {bool isLiked = false, bool isFavorite = false}) {
    final sourceType = switch (model.sourceType) {
      'remote_http' => VideoSourceType.remoteHttp,
      'external' => VideoSourceType.external,
      _ => VideoSourceType.local,
    };

    return Video(
      id: model.id,
      title: model.title,
      description: model.description,
      creator: model.creator,
      url: model.url,
      sourceLabel: model.sourceLabel,
      sourceType: sourceType,
      thumbnailUrl: model.thumbnailUrl,
      initialLikes: model.initialLikes,
      views: model.views,
      isAvailable: model.isAvailable,
      isDemo: model.isDemo,
      isLiked: isLiked,
      isFavorite: isFavorite,
    );
  }

  static VideoModel toModel(Video video) {
    return VideoModel(
      id: video.id,
      title: video.title,
      description: video.description,
      creator: video.creator,
      url: video.url,
      sourceLabel: video.sourceLabel,
      sourceType: video.sourceType.value,
      thumbnailUrl: video.thumbnailUrl,
      initialLikes: video.initialLikes,
      views: video.views,
      isAvailable: video.isAvailable,
      isDemo: video.isDemo,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:practica_04/domain/entities/video_post.dart';
import 'package:practica_04/infrastructure/models/local_video_model.dart';
import 'package:practica_04/shared/data/local_video_posts.dart';

class DiscoverProvider extends ChangeNotifier {
  

  bool initialLoading = true;
  List<VideoPost> videos = [];

  Future<void> loadNextPage() async {
    
    final List<VideoPost> newVideos = videoPosts
        .map(
          (video) => LocalVideoModel.fromJson(video).toVideoPostEntity(),
        )
        .toList();

    videos.addAll(newVideos);
    initialLoading = false;
    notifyListeners();
  }
}

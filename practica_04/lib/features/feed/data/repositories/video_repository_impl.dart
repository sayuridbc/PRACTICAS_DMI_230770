import 'package:practica_04/features/feed/data/datasources/external_video_data_source.dart';
import 'package:practica_04/features/feed/data/datasources/local_video_data_source.dart';
import 'package:practica_04/features/feed/data/datasources/remote_video_data_source.dart';
import 'package:practica_04/features/feed/data/mappers/video_mapper.dart';
import 'package:practica_04/features/feed/domain/entities/video.dart';
import 'package:practica_04/features/feed/domain/repositories/video_repository.dart';

class VideoRepositoryImpl implements VideoRepository {
  final LocalVideoDataSource localDataSource;
  final RemoteVideoDataSource remoteDataSource;
  final ExternalVideoDataSource externalDataSource;

  VideoRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
    required this.externalDataSource,
  });

  @override
  Future<List<Video>> getFeed() async {
    final local = await localDataSource.loadVideos();
    final remote = await remoteDataSource.loadVideos();
    final external = await externalDataSource.loadVideos();

    final merged = <Video>[];
    final seen = <String>{};

    for (final source in [local, remote, external]) {
      for (final model in source) {
        if (seen.contains(model.id)) {
          continue;
        }
        seen.add(model.id);
        merged.add(VideoMapper.fromModel(model));
      }
    }

    return merged;
  }

  @override
  Future<List<Video>> getForYou() async {
    final all = await getFeed();
    return all.where((video) => video.sourceType != null).toList();
  }

  @override
  Future<List<Video>> getFavorites(List<String> favoriteIds) async {
    final all = await getFeed();
    final favorites = all.where((video) => favoriteIds.contains(video.id)).toList();
    return favorites;
  }
}

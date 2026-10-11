import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:practica_04/features/feed/data/datasources/video_data_source.dart';
import 'package:practica_04/features/feed/data/models/video_model.dart';

class RemoteVideoDataSource implements VideoDataSource {
  final String endpoint;

  RemoteVideoDataSource({this.endpoint = 'https://example.com/feed.json'});

  @override
  Future<List<VideoModel>> loadVideos() async {
    try {
      final response = await http.get(Uri.parse(endpoint)).timeout(const Duration(seconds: 8));
      if (response.statusCode != 200) {
        return _fallbackVideos();
      }

      final decoded = jsonDecode(response.body) as List<dynamic>;
      return decoded.map((item) => VideoModel.fromJson(Map<String, dynamic>.from(item))).toList();
    } catch (_) {
      return _fallbackVideos();
    }
  }

  List<VideoModel> _fallbackVideos() {
    return [
      VideoModel(
        id: 'remote-demo-01',
        title: 'Remote demo feed',
        description: 'Remote HTTP datasource is available but the external endpoint is not configured yet. Replace this record with the real feed URL when you have it.',
        creator: 'HTTP Demo',
        url: 'https://www.w3schools.com/html/mov_bbb.mp4',
        sourceLabel: 'Remote HTTP demo',
        sourceType: 'remote_http',
        initialLikes: 1820,
        views: 20800,
        isAvailable: true,
        isDemo: true,
      ),
    ];
  }
}

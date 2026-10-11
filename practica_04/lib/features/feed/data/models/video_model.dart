import 'package:practica_04/core/constants/video_source_types.dart';

class VideoModel {
  final String id;
  final String title;
  final String description;
  final String creator;
  final String url;
  final String sourceLabel;
  final String sourceType;
  final String? thumbnailUrl;
  final int initialLikes;
  final int views;
  final bool isAvailable;
  final bool isDemo;

  const VideoModel({
    required this.id,
    required this.title,
    required this.description,
    required this.creator,
    required this.url,
    required this.sourceLabel,
    required this.sourceType,
    this.thumbnailUrl,
    required this.initialLikes,
    required this.views,
    required this.isAvailable,
    required this.isDemo,
  });

  factory VideoModel.fromJson(Map<String, dynamic> json) {
    final String sourceTypeRaw = (json['sourceType'] ?? 'local') as String;
    return VideoModel(
      id: (json['id'] ?? '').toString(),
      title: (json['title'] ?? 'Sin título').toString(),
      description: (json['description'] ?? 'Sin descripción').toString(),
      creator: (json['creator'] ?? 'Creator').toString(),
      url: (json['url'] ?? '').toString(),
      sourceLabel: (json['sourceLabel'] ?? 'Fuente').toString(),
      sourceType: sourceTypeRaw,
      thumbnailUrl: json['thumbnailUrl'] as String?,
      initialLikes: int.tryParse('${json['initialLikes']}') ?? 0,
      views: int.tryParse('${json['views']}') ?? 0,
      isAvailable: json['isAvailable'] as bool? ?? true,
      isDemo: json['isDemo'] as bool? ?? false,
    );
  }
}

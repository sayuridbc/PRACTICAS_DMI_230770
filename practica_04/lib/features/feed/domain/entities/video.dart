import 'package:practica_04/core/constants/video_source_types.dart';

class Video {
  final String id;
  final String title;
  final String description;
  final String creator;
  final String url;
  final String sourceLabel;
  final VideoSourceType sourceType;
  final String? thumbnailUrl;
  final int initialLikes;
  final int views;
  final bool isAvailable;
  final bool isDemo;
  final bool isLiked;
  final bool isFavorite;

  Video({
    required this.id,
    required this.title,
    required this.description,
    required this.creator,
    required this.url,
    required this.sourceLabel,
    required this.sourceType,
    this.thumbnailUrl,
    this.initialLikes = 0,
    this.views = 0,
    this.isAvailable = true,
    this.isDemo = false,
    this.isLiked = false,
    this.isFavorite = false,
  }) : assert(id.trim().isNotEmpty),
       assert(title.trim().isNotEmpty),
       assert(url.trim().isNotEmpty);

  Video copyWith({
    String? id,
    String? title,
    String? description,
    String? creator,
    String? url,
    String? sourceLabel,
    VideoSourceType? sourceType,
    String? thumbnailUrl,
    int? initialLikes,
    int? views,
    bool? isAvailable,
    bool? isDemo,
    bool? isLiked,
    bool? isFavorite,
  }) {
    return Video(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      creator: creator ?? this.creator,
      url: url ?? this.url,
      sourceLabel: sourceLabel ?? this.sourceLabel,
      sourceType: sourceType ?? this.sourceType,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      initialLikes: initialLikes ?? this.initialLikes,
      views: views ?? this.views,
      isAvailable: isAvailable ?? this.isAvailable,
      isDemo: isDemo ?? this.isDemo,
      isLiked: isLiked ?? this.isLiked,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  int get totalLikes => initialLikes + (isLiked ? 1 : 0);
}

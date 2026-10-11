import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:practica_04/features/feed/domain/entities/video.dart';
import 'package:practica_04/features/feed/presentation/widgets/expandable_description.dart';

class VideoPlayerCard extends StatefulWidget {
  final Video video;
  final bool isMuted;
  final VoidCallback onLike;
  final VoidCallback onFavorite;
  final VoidCallback onToggleSound;

  const VideoPlayerCard({
    super.key,
    required this.video,
    required this.isMuted,
    required this.onLike,
    required this.onFavorite,
    required this.onToggleSound,
  });

  @override
  State<VideoPlayerCard> createState() => _VideoPlayerCardState();
}

class _VideoPlayerCardState extends State<VideoPlayerCard> {
  late final VideoPlayerController _controller;
  bool _initialized = false;
  bool _loading = true;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.video.url));
    _controller.setLooping(true).then((_) => _initialize());
  }

  Future<void> _initialize() async {
    try {
      await _controller.initialize();
      await _controller.setVolume(widget.isMuted ? 0 : 1);
      await _controller.play();
      setState(() {
        _initialized = true;
        _loading = false;
        _isPlaying = true;
      });
    } catch (_) {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  void didUpdateWidget(covariant VideoPlayerCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isMuted != widget.isMuted) {
      _controller.setVolume(widget.isMuted ? 0 : 1);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Stack(
      fit: StackFit.expand,
      children: [
        if (_initialized)
          GestureDetector(
            onTap: () {
              if (_controller.value.isPlaying) {
                _controller.pause();
                setState(() => _isPlaying = false);
              } else {
                _controller.play();
                setState(() => _isPlaying = true);
              }
            },
            child: AspectRatio(
              aspectRatio: _controller.value.aspectRatio == 0 ? 9 / 16 : _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            ),
          )
        else
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [theme.colorScheme.primary.withOpacity(0.35), theme.colorScheme.secondary.withOpacity(0.25)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
                stops: const [0.65, 1],
              ),
            ),
          ),
        ),
        Positioned(
          left: 16,
          right: 72,
          bottom: 20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '@${widget.video.creator}',
                style: theme.textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                widget.video.title,
                style: theme.textTheme.titleLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              ExpandableDescription(text: widget.video.description),
              const SizedBox(height: 6),
              Text(
                '${widget.video.sourceLabel} • ${widget.video.views} views',
                style: theme.textTheme.bodySmall?.copyWith(color: Colors.white70),
              ),
            ],
          ),
        ),
        Positioned(
          right: 16,
          bottom: 18,
          child: Column(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: widget.video.thumbnailUrl != null
                    ? NetworkImage(widget.video.thumbnailUrl!)
                    : null,
                backgroundColor: Colors.white24,
                child: widget.video.thumbnailUrl == null
                    ? const Icon(Icons.person, color: Colors.white)
                    : null,
              ),
              const SizedBox(height: 14),
              IconButton(
                onPressed: widget.onLike,
                icon: Icon(
                  widget.video.isLiked ? Icons.favorite : Icons.favorite_border,
                  color: widget.video.isLiked ? Colors.pink : Colors.white,
                  size: 30,
                ),
              ),
              Text(
                widget.video.totalLikes.toString(),
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
              const SizedBox(height: 10),
              IconButton(
                onPressed: widget.onFavorite,
                icon: Icon(
                  widget.video.isFavorite ? Icons.bookmark : Icons.bookmark_border,
                  color: Colors.white,
                  size: 28,
                ),
              ),
              IconButton(
                onPressed: widget.onToggleSound,
                icon: Icon(
                  widget.isMuted ? Icons.volume_off : Icons.volume_up,
                  color: Colors.white,
                  size: 28,
                ),
              ),
            ],
          ),
        ),
        if (_loading)
          const Positioned.fill(
            child: Center(
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          ),
        if (!_initialized && !_loading)
          Positioned.fill(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.videocam_off, color: Colors.white70, size: 50),
                  const SizedBox(height: 12),
                  Text(
                    'Video unavailable',
                    style: theme.textTheme.titleMedium?.copyWith(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        if (_initialized && !_isPlaying)
          const Positioned.fill(
            child: Center(
              child: Icon(Icons.play_circle_outline, color: Colors.white, size: 48),
            ),
          ),
      ],
    );
  }
}

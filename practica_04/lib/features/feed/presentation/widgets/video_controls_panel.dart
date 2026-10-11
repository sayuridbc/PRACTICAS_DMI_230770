import 'package:flutter/material.dart';
import 'package:practica_04/config/helpers/human_formats.dart';
import 'package:practica_04/features/feed/domain/entities/video.dart';

class VideoControlsPanel extends StatelessWidget {
  final Video video;
  final bool isMuted;
  final VoidCallback onLike;
  final VoidCallback onFavorite;
  final VoidCallback onToggleSound;

  const VideoControlsPanel({
    super.key,
    required this.video,
    required this.isMuted,
    required this.onLike,
    required this.onFavorite,
    required this.onToggleSound,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          radius: 26,
          backgroundColor: Colors.white.withOpacity(0.2),
          child: Text(
            video.creator.trim().substring(0, 1).toUpperCase(),
            style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        const SizedBox(height: 14),
        _ActionButton(
          icon: video.isLiked ? Icons.favorite : Icons.favorite_border,
          value: video.totalLikes,
          color: Colors.pink,
          onTap: onLike,
        ),
        const SizedBox(height: 14),
        _ActionButton(
          icon: video.isFavorite ? Icons.bookmark : Icons.bookmark_border,
          value: 0,
          color: Colors.white,
          onTap: onFavorite,
        ),
        const SizedBox(height: 14),
        _ActionButton(
          icon: isMuted ? Icons.volume_off : Icons.volume_up,
          value: 0,
          color: Colors.white,
          onTap: onToggleSound,
        ),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final int value;
  final Color color;
  final VoidCallback onTap;

  const _ActionButton({
    super.key,
    required this.icon,
    required this.value,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Icon(icon, color: color, size: 30),
          if (value > 0) ...[
            const SizedBox(height: 6),
            Text(
              HumanFormats.humanReadbleNumber(value.toDouble()),
              style: const TextStyle(color: Colors.white, fontSize: 11),
            ),
          ],
        ],
      ),
    );
  }
}

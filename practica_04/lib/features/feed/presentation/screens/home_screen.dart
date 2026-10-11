import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:practica_04/features/feed/domain/entities/video.dart';
import 'package:practica_04/features/feed/presentation/providers/video_feed_provider.dart';
import 'package:practica_04/features/feed/presentation/widgets/video_player_card.dart';
import 'package:practica_04/features/seasonal_theme/presentation/providers/seasonal_theme_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final seasonalTheme = context.watch<SeasonalThemeProvider>().currentTheme;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: seasonalTheme.gradient.first,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text('TokTik'),
          actions: [
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () => _showThemeSettings(context),
            ),
          ],
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Discover'),
              Tab(text: 'For You'),
              Tab(text: 'Favorites'),
            ],
          ),
        ),
        body: Consumer<VideoFeedProvider>(
          builder: (context, provider, _) {
            if (provider.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            final discoverVideos = provider.videos;
            final forYouVideos = provider.videos;
            final favoriteVideos = provider.favorites;

            return TabBarView(
              children: [
                _VideoPageList(videos: discoverVideos),
                _VideoPageList(videos: forYouVideos),
                _VideoPageList(videos: favoriteVideos, emptyText: 'No favorites yet'),
              ],
            );
          },
        ),
      ),
    );
  }

  Future<void> _showThemeSettings(BuildContext context) async {
    final themeProvider = context.read<SeasonalThemeProvider>();
    final theme = themeProvider.currentTheme;

    await showDialog<void>(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text('Seasonal theme'),
          content: StatefulBuilder(
            builder: (context, setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SwitchListTile(
                    title: const Text('Automatic mode'),
                    value: themeProvider.autoMode,
                    onChanged: (value) async {
                      await themeProvider.setAutoMode(value);
                      setState(() {});
                    },
                  ),
                  ...SeasonalThemes.all.map((item) {
                    final selected = item.id == themeProvider.manualThemeId;
                    return RadioListTile<String>(
                      title: Text(item.label),
                      value: item.id,
                      groupValue: themeProvider.autoMode ? theme.id : themeProvider.manualThemeId,
                      onChanged: (v) async {
                        if (v == null) return;
                        await themeProvider.setManualTheme(v);
                        setState(() {});
                      },
                      selected: selected,
                    );
                  }),
                ],
              );
            },
          ),
        );
      },
    );
  }
}

class _VideoPageList extends StatelessWidget {
  final List<Video> videos;
  final String emptyText;

  const _VideoPageList({required this.videos, this.emptyText = 'No videos available'});

  @override
  Widget build(BuildContext context) {
    if (videos.isEmpty) {
      return Center(
        child: Text(emptyText, style: const TextStyle(color: Colors.white)),
      );
    }

    return PageView.builder(
      scrollDirection: Axis.vertical,
      itemCount: videos.length,
      itemBuilder: (context, index) {
        final video = videos[index];
        return Consumer<VideoFeedProvider>(
          builder: (context, provider, _) {
            final videoItem = provider.videos.firstWhere(
              (item) => item.id == video.id,
              orElse: () => video,
            );

            return Padding(
              padding: const EdgeInsets.only(bottom: 0),
              child: VideoPlayerCard(
                video: videoItem,
                isMuted: false,
                onLike: () => provider.toggleLike(videoItem.id),
                onFavorite: () => provider.toggleFavorite(videoItem.id),
                onToggleSound: () {},
              ),
            );
          },
        );
      },
    );
  }
}

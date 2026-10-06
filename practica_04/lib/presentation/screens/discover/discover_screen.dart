import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:practica_04/presentation/providers/discover_provider.dart';
import 'package:practica_04/presentation/widgets/shared/video_scrollable_view.dart';

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Consumer<DiscoverProvider>(
          builder: (context, provider, _) {
            if (provider.initialLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (provider.videos.isEmpty) {
              return const Center(child: Text('No hay videos disponibles.'));
            }

            return VideoScrollableView(videos: provider.videos);
          },
        ),
      ),
    );
  }
}

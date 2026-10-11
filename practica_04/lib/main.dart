import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:practica_04/features/favorites/presentation/providers/favorites_provider.dart';
import 'package:practica_04/features/feed/presentation/providers/video_feed_provider.dart';
import 'package:practica_04/features/feed/presentation/screens/home_screen.dart';
import 'package:practica_04/features/seasonal_theme/presentation/providers/seasonal_theme_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => VideoFeedProvider()),
        ChangeNotifierProvider(create: (_) => SeasonalThemeProvider()),
        ChangeNotifierProvider(create: (_) => FavoritesProvider()),
      ],
      child: Consumer<SeasonalThemeProvider>(
        builder: (context, themeProvider, _) {
          final theme = themeProvider.currentTheme;
          return MaterialApp(
            title: 'TokTik',
            debugShowCheckedModeBanner: false,
            theme: theme.theme,
            home: const HomeScreen(),
          );
        },
      ),
    );
  }
}

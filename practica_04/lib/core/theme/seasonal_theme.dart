import 'package:flutter/material.dart';

class SeasonalThemeConfig {
  final String id;
  final String label;
  final ThemeData theme;
  final List<Color> gradient;

  const SeasonalThemeConfig({
    required this.id,
    required this.label,
    required this.theme,
    required this.gradient,
  });
}

class SeasonalThemes {
  static final SeasonalThemeConfig normal = SeasonalThemeConfig(
    id: 'normal',
    label: 'Normal',
    theme: ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF1A1A2E),
        brightness: Brightness.dark,
      ),
      scaffoldBackgroundColor: const Color(0xFF0F172A),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
    ),
    gradient: const [
      Color(0xFF0F172A),
      Color(0xFF111827),
    ],
  );

  static final SeasonalThemeConfig halloween = SeasonalThemeConfig(
    id: 'halloween',
    label: 'Halloween',
    theme: ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF7C2D12),
        brightness: Brightness.dark,
      ),
      scaffoldBackgroundColor: const Color(0xFF1C0F0B),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
    ),
    gradient: const [
      Color(0xFF1C0F0B),
      Color(0xFF4A1D0B),
    ],
  );

  static final SeasonalThemeConfig christmas = SeasonalThemeConfig(
    id: 'christmas',
    label: 'Christmas',
    theme: ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF14532D),
        brightness: Brightness.dark,
      ),
      scaffoldBackgroundColor: const Color(0xFF071A12),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
    ),
    gradient: const [
      Color(0xFF071A12),
      Color(0xFF14532D),
    ],
  );

  static final SeasonalThemeConfig valentines = SeasonalThemeConfig(
    id: 'valentines',
    label: 'Valentines',
    theme: ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF831843),
        brightness: Brightness.dark,
      ),
      scaffoldBackgroundColor: const Color(0xFF1F0A18),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
    ),
    gradient: const [
      Color(0xFF1F0A18),
      Color(0xFF7F1D1D),
    ],
  );

  static List<SeasonalThemeConfig> get all => [
        normal,
        halloween,
        christmas,
        valentines,
      ];

  static SeasonalThemeConfig byId(String? id) {
    switch (id) {
      case 'halloween':
        return halloween;
      case 'christmas':
        return christmas;
      case 'valentines':
        return valentines;
      case 'normal':
      default:
        return normal;
    }
  }
}

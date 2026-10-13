import 'package:flutter/material.dart';

class AppTheme {
  final int selectedColor;

  const AppTheme({this.selectedColor = 0});

  ThemeData getTheme() {
    final colors = Colors.primaries;

    return ThemeData(
      useMaterial3: true,
      colorSchemeSeed: colors[selectedColor % colors.length],
    );
  }
}
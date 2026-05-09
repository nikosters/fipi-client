import 'package:flutter/material.dart';

ThemeData buildAppTheme() {
  const background = Color(0xff0b0f14);
  const surface = Color(0xff111820);
  const border = Color(0xff263241);
  const text = Color(0xffe6edf3);
  const muted = Color(0xff9aa7b4);
  const primary = Color(0xff7db7ff);

  final scheme =
      ColorScheme.fromSeed(
        seedColor: primary,
        brightness: Brightness.dark,
        surface: surface,
      ).copyWith(
        primary: primary,
        onPrimary: const Color(0xff07111d),
        surface: surface,
        onSurface: text,
        outline: border,
      );

  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: scheme,
    scaffoldBackgroundColor: background,
    appBarTheme: const AppBarTheme(
      backgroundColor: background,
      foregroundColor: text,
      elevation: 0,
      centerTitle: false,
      surfaceTintColor: Colors.transparent,
    ),
    cardTheme: CardThemeData(
      color: surface,
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(color: border),
      ),
    ),
    dividerTheme: const DividerThemeData(color: border, thickness: 1),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xff0f1620),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: border),
      ),
    ),
    listTileTheme: const ListTileThemeData(
      textColor: text,
      iconColor: muted,
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 2),
    ),
  );
}

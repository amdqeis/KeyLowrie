import 'package:flutter/material.dart';

abstract final class KeySpaceColors {
  static const paper = Color(0xFFF5F3EE);
  static const ink = Color(0xFF111111);
  static const white = Color(0xFFFFFFFF);
  static const signalYellow = Color(0xFFFFD60A);
  static const signalYellowDark = Color(0xFFE6C200);
  static const healthy = Color(0xFF3BB273);
  static const error = Color(0xFFE4572E);
  static const neutral = Color(0xFFE5E5E0);
  static const warning = Color(0xFFFFA62B);
  static const limited = Color(0xFFFF8C42);
}

abstract final class KeySpaceTheme {
  static ThemeData get light => _build(
    brightness: Brightness.light,
    paper: KeySpaceColors.paper,
    ink: KeySpaceColors.ink,
    surface: KeySpaceColors.white,
  );

  static ThemeData get dark => _build(
    brightness: Brightness.dark,
    paper: KeySpaceColors.ink,
    ink: KeySpaceColors.paper,
    surface: const Color(0xFF202020),
  );

  static ThemeData _build({
    required Brightness brightness,
    required Color paper,
    required Color ink,
    required Color surface,
  }) {
    final base = ThemeData(
      useMaterial3: true,
      brightness: brightness,
      scaffoldBackgroundColor: paper,
      colorScheme: ColorScheme.fromSeed(
        seedColor: KeySpaceColors.signalYellow,
        brightness: brightness,
        surface: surface,
      ),
    );
    final border = BorderSide(color: ink, width: 3);
    return base.copyWith(
      textTheme: base.textTheme.apply(
        bodyColor: ink,
        displayColor: ink,
        fontFamily: 'sans-serif',
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: paper,
        elevation: 0,
        indicatorColor: KeySpaceColors.signalYellow,
        labelTextStyle: WidgetStatePropertyAll(
          TextStyle(color: ink, fontWeight: FontWeight.w800, fontSize: 11),
        ),
        iconTheme: WidgetStatePropertyAll(IconThemeData(color: ink)),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: paper,
        foregroundColor: ink,
        elevation: 0,
        centerTitle: false,
        shape: Border(bottom: border),
        titleTextStyle: TextStyle(
          color: ink,
          fontSize: 24,
          fontWeight: FontWeight.w800,
        ),
      ),
      cardTheme: CardThemeData(
        color: surface,
        elevation: 0,
        margin: const EdgeInsets.all(8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: border,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: border,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: border,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: KeySpaceColors.signalYellow,
            width: 3,
          ),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: KeySpaceColors.signalYellow,
          foregroundColor: KeySpaceColors.ink,
          elevation: 0,
          minimumSize: const Size(48, 48),
          textStyle: const TextStyle(fontWeight: FontWeight.w800),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: border,
          ),
        ),
      ),
      dividerTheme: DividerThemeData(color: ink, thickness: 2),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: surface,
        contentTextStyle: TextStyle(color: ink, fontWeight: FontWeight.w700),
        actionTextColor: KeySpaceColors.ink,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: border,
        ),
      ),
    );
  }
}

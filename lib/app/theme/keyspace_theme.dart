import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
  // Dark mode surfaces
  static const darkSurface = Color(0xFF1C1C1C);
  static const darkPaper = Color(0xFF111111);
}

abstract final class KeySpaceFonts {
  static TextStyle grotesk({
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
    double? letterSpacing,
    double? height,
  }) =>
      GoogleFonts.spaceGrotesk(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        letterSpacing: letterSpacing,
        height: height,
      );

  static TextStyle mono({
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
  }) =>
      GoogleFonts.ibmPlexMono(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
      );
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
    paper: KeySpaceColors.darkPaper,
    ink: KeySpaceColors.paper,
    surface: KeySpaceColors.darkSurface,
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

    final baseTextTheme = GoogleFonts.spaceGroteskTextTheme(base.textTheme);

    return base.copyWith(
      textTheme: baseTextTheme.copyWith(
        displayLarge: baseTextTheme.displayLarge?.copyWith(
          color: ink, fontWeight: FontWeight.w900,
        ),
        displayMedium: baseTextTheme.displayMedium?.copyWith(
          color: ink, fontWeight: FontWeight.w900,
        ),
        displaySmall: baseTextTheme.displaySmall?.copyWith(
          color: ink, fontWeight: FontWeight.w900,
        ),
        headlineLarge: baseTextTheme.headlineLarge?.copyWith(
          color: ink, fontWeight: FontWeight.w800,
        ),
        headlineMedium: baseTextTheme.headlineMedium?.copyWith(
          color: ink, fontWeight: FontWeight.w800,
        ),
        headlineSmall: baseTextTheme.headlineSmall?.copyWith(
          color: ink, fontWeight: FontWeight.w800,
        ),
        titleLarge: baseTextTheme.titleLarge?.copyWith(
          color: ink, fontWeight: FontWeight.w900,
        ),
        titleMedium: baseTextTheme.titleMedium?.copyWith(
          color: ink, fontWeight: FontWeight.w700,
        ),
        bodyLarge: baseTextTheme.bodyLarge?.copyWith(color: ink),
        bodyMedium: baseTextTheme.bodyMedium?.copyWith(color: ink),
        bodySmall: baseTextTheme.bodySmall?.copyWith(color: ink),
        labelLarge: baseTextTheme.labelLarge?.copyWith(
          color: ink,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.5,
        ),
        labelSmall: baseTextTheme.labelSmall?.copyWith(
          color: ink,
          fontWeight: FontWeight.w800,
          letterSpacing: 1.2,
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: paper,
        elevation: 0,
        height: 64,
        indicatorColor: KeySpaceColors.signalYellow,
        indicatorShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
          side: BorderSide(color: ink, width: 2),
        ),
        labelTextStyle: WidgetStatePropertyAll(
          GoogleFonts.spaceGrotesk(
            color: ink,
            fontWeight: FontWeight.w800,
            fontSize: 11,
            letterSpacing: 0.3,
          ),
        ),
        iconTheme: WidgetStatePropertyAll(IconThemeData(color: ink, size: 22)),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: paper,
        foregroundColor: ink,
        elevation: 0,
        centerTitle: false,
        shape: Border(bottom: BorderSide(color: ink, width: 3)),
        titleTextStyle: GoogleFonts.spaceGrotesk(
          color: ink,
          fontSize: 22,
          fontWeight: FontWeight.w900,
          letterSpacing: -0.3,
        ),
        toolbarHeight: 58,
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
        labelStyle: GoogleFonts.spaceGrotesk(
          color: ink.withValues(alpha: 0.7),
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
        floatingLabelStyle: GoogleFonts.spaceGrotesk(
          color: ink,
          fontWeight: FontWeight.w800,
          fontSize: 13,
        ),
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
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: KeySpaceColors.signalYellow,
          foregroundColor: KeySpaceColors.ink,
          elevation: 0,
          minimumSize: const Size(48, 52),
          textStyle: GoogleFonts.spaceGrotesk(
            fontWeight: FontWeight.w800,
            fontSize: 14,
            letterSpacing: 0.5,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(color: ink, width: 3),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: ink,
          minimumSize: const Size(48, 52),
          textStyle: GoogleFonts.spaceGrotesk(
            fontWeight: FontWeight.w800,
            fontSize: 14,
            letterSpacing: 0.5,
          ),
          side: BorderSide(color: ink, width: 3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: ink,
          textStyle: GoogleFonts.spaceGrotesk(
            fontWeight: FontWeight.w800,
            fontSize: 13,
            letterSpacing: 0.5,
          ),
        ),
      ),
      checkboxTheme: CheckboxThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        side: BorderSide(color: ink, width: 2),
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return KeySpaceColors.signalYellow;
          }
          return Colors.transparent;
        }),
        checkColor: WidgetStatePropertyAll(ink),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return ink;
          return ink.withValues(alpha: 0.4);
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return KeySpaceColors.signalYellow;
          }
          return ink.withValues(alpha: 0.1);
        }),
        trackOutlineColor: WidgetStatePropertyAll(ink),
      ),
      dividerTheme: DividerThemeData(color: ink, thickness: 2),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: surface,
        contentTextStyle: GoogleFonts.spaceGrotesk(
          color: ink,
          fontWeight: FontWeight.w700,
        ),
        actionTextColor: KeySpaceColors.ink,
        behavior: SnackBarBehavior.floating,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: ink, width: 3),
        ),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: ink, width: 3),
        ),
        titleTextStyle: GoogleFonts.spaceGrotesk(
          color: ink,
          fontSize: 18,
          fontWeight: FontWeight.w900,
          letterSpacing: -0.2,
        ),
        contentTextStyle: GoogleFonts.spaceGrotesk(
          color: ink,
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

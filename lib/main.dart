import 'package:flutter/material.dart';
import 'package:habit_tracker/view/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  ColorScheme get _colorScheme {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xFF00CF56),
      onPrimary: Color(0xFFFFFFFF),
      primaryContainer: Color(0xFF4BF67E),
      onPrimaryContainer: Color(0xFF000000),
      secondary: Color(0xFF00A775),
      onSecondary: Color(0xFF000000),
      secondaryContainer: Color(0xFF11FFB7),
      onSecondaryContainer: Color(0xFF000000),
      tertiary: Color(0xFF2D8C81),
      onTertiary: Color(0xFFFFFFFF),
      tertiaryContainer: Color(0xFF79E8DB),
      onTertiaryContainer: Color(0xFF000000),
      error: Color(0xFFFF5921),
      onError: Color(0xFFFFFFFF),
      errorContainer: Color(0xFFFFF3EB),
      onErrorContainer: Color(0xFFFF5921),
      surface: Color(0xFFFFF5F5),
      surfaceContainer: Color(0xFFC8FFE2),
      surfaceContainerHigh: Color(0xFFB8FFD9),
      onSurface: Color(0xFF000000),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Habit Tracker',
      theme: ThemeData(
        colorScheme: _colorScheme,
        textTheme: const TextTheme(
          displaySmall: TextStyle(fontSize: 32.0),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: _colorScheme.primaryContainer,
          foregroundColor: _colorScheme.onPrimaryContainer,
        ),
        dialogTheme: DialogTheme(
          backgroundColor: _colorScheme.surfaceContainer,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(_colorScheme.primary),
            foregroundColor: WidgetStatePropertyAll(_colorScheme.onPrimary),
          ),
        ),
        checkboxTheme: CheckboxThemeData(
          side: BorderSide(
            width: 2.2,
            color: _colorScheme.primary.withAlpha(0xCC),
          ),
        ),
      ),
      home: const HomePage(),
    );
  }
}

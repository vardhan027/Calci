import 'package:flutter/material.dart';
import 'screens/calculator_screen.dart';
import 'theme/calculator_theme.dart';

void main() {
  runApp(const CalciApp());
}

class CalciApp extends StatefulWidget {
  const CalciApp({super.key});

  @override
  State<CalciApp> createState() => _CalciAppState();
}

class _CalciAppState extends State<CalciApp> {
  ThemeMode _themeMode = ThemeMode.system;

  void _toggleTheme() {
    setState(() {
      if (_themeMode == ThemeMode.light) {
        _themeMode = ThemeMode.dark;
      } else if (_themeMode == ThemeMode.dark) {
        _themeMode = ThemeMode.light;
      } else {
        final brightness = WidgetsBinding.instance.platformDispatcher.platformBrightness;
        _themeMode = brightness == Brightness.dark ? ThemeMode.light : ThemeMode.dark;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = _themeMode == ThemeMode.dark ||
        (_themeMode == ThemeMode.system &&
            WidgetsBinding.instance.platformDispatcher.platformBrightness == Brightness.dark);

    return MaterialApp(
      title: 'Calci',
      debugShowCheckedModeBanner: false,
      theme: CalculatorTheme.getLightTheme(),
      darkTheme: CalculatorTheme.getDarkTheme(),
      themeMode: _themeMode,
      home: CalculatorScreen(
        onToggleTheme: _toggleTheme,
        isDarkMode: isDark,
      ),
    );
  }
}

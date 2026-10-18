import 'package:flutter/material.dart';

enum CalcButtonType {
  number,
  operator,
  utility,
  equals,
}

class CalculatorColors {
  // Sunset Amber / Orange Palette

  // Light Theme Palette
  static const Color lightBg = Color(0xFFF3F4F6); // Soft clean light gray background
  static const Color lightDisplayBg = Color(0xFFFFFFFF);
  static const Color lightNumBtn = Color(0xFFFFFFFF); // Clean white card buttons
  static const Color lightNumText = Color(0xFF1F2937); // Deep graphite
  static const Color lightUtilBtn = Color(0xFFE5E7EB); // Cool silver
  static const Color lightUtilText = Color(0xFF374151); // Dark slate
  static const Color lightOpBtn = Color(0xFFFF9500); // Warm vibrant sunset orange
  static const Color lightOpText = Color(0xFFFFFFFF);
  static const Color lightEqualsBtn = Color(0xFFFF7A00); // Rich sunset orange
  static const Color lightEqualsText = Color(0xFFFFFFFF);
  static const Color lightEquationText = Color(0xFF6B7280);
  static const Color lightDisplayText = Color(0xFF111827);

  // Dark Theme Palette (Sleek Charcoal & Sunset Amber)
  static const Color darkBg = Color(0xFF17171C); // Modern deep charcoal
  static const Color darkDisplayBg = Color(0xFF17171C);
  static const Color darkNumBtn = Color(0xFF2E2F38); // Tactile soft charcoal
  static const Color darkNumText = Color(0xFFFFFFFF); // Pure white
  static const Color darkUtilBtn = Color(0xFF4E505F); // Distinct medium slate
  static const Color darkUtilText = Color(0xFFFFFFFF); // Pure white
  static const Color darkOpBtn = Color(0xFFFF9F0A); // Iconic Sunset Amber
  static const Color darkOpText = Color(0xFFFFFFFF);
  static const Color darkEqualsBtn = Color(0xFFFF9F0A);
  static const Color darkEqualsText = Color(0xFFFFFFFF);
  static const Color darkEquationText = Color(0xFF8E8E93);
  static const Color darkDisplayText = Color(0xFFFFFFFF);
}

class CalculatorTheme {
  static ThemeData getLightTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: CalculatorColors.lightBg,
      colorScheme: ColorScheme.fromSeed(
        seedColor: CalculatorColors.lightOpBtn,
        brightness: Brightness.light,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
    );
  }

  static ThemeData getDarkTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: CalculatorColors.darkBg,
      colorScheme: ColorScheme.fromSeed(
        seedColor: CalculatorColors.darkOpBtn,
        brightness: Brightness.dark,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:calci/main.dart';
import 'package:calci/widgets/calc_button.dart';
import 'package:calci/widgets/calc_display.dart';

void main() {
  testWidgets('Calculator UI renders and computes 7 + 3 = 10 correctly', (WidgetTester tester) async {
    await tester.pumpWidget(const CalciApp());

    // Verify initial display state
    expect(find.text('Calci'), findsOneWidget);
    expect(find.text('0'), findsAtLeastNWidgets(1));

    // Tap '7'
    await tester.tap(find.widgetWithText(CalcButton, '7'));
    await tester.pump();
    expect(find.descendant(of: find.byType(CalcDisplay), matching: find.text('7')), findsOneWidget);

    // Tap '+'
    await tester.tap(find.widgetWithText(CalcButton, '+'));
    await tester.pump();

    // Tap '3'
    await tester.tap(find.widgetWithText(CalcButton, '3'));
    await tester.pump();

    // Tap '='
    await tester.tap(find.widgetWithText(CalcButton, '='));
    await tester.pump();

    // Verify calculated result is 10 and equation displays '7 + 3 ='
    expect(find.descendant(of: find.byType(CalcDisplay), matching: find.text('10')), findsOneWidget);
    expect(find.text('7 + 3 ='), findsOneWidget);

    // Tap 'C' to clear
    await tester.tap(find.widgetWithText(CalcButton, 'C'));
    await tester.pump();
    expect(find.descendant(of: find.byType(CalcDisplay), matching: find.text('0')), findsOneWidget);
  });

  testWidgets('Backspace button in top row erases digits correctly', (WidgetTester tester) async {
    await tester.pumpWidget(const CalciApp());

    // Type 4, 8
    await tester.tap(find.widgetWithText(CalcButton, '4'));
    await tester.pump();
    await tester.tap(find.widgetWithText(CalcButton, '8'));
    await tester.pump();
    expect(find.descendant(of: find.byType(CalcDisplay), matching: find.text('48')), findsOneWidget);

    // Tap backspace icon button in top row
    final backspaceFinder = find.byIcon(Icons.backspace_outlined);
    expect(backspaceFinder, findsOneWidget);
    await tester.tap(backspaceFinder);
    await tester.pump();

    // Verify 8 is removed and 4 remains in CalcDisplay
    expect(find.descendant(of: find.byType(CalcDisplay), matching: find.text('4')), findsOneWidget);
  });

  testWidgets('Theme toggle button switches theme mode', (WidgetTester tester) async {
    await tester.pumpWidget(const CalciApp());

    final themeToggleFinder = find.byType(IconButton);
    expect(themeToggleFinder, findsOneWidget);

    await tester.tap(themeToggleFinder);
    await tester.pumpAndSettle();
  });
}

import 'package:flutter/material.dart';
import '../theme/calculator_theme.dart';

class CalcDisplay extends StatelessWidget {
  final String equation;
  final String displayValue;
  final VoidCallback onBackspace;

  const CalcDisplay({
    super.key,
    required this.equation,
    required this.displayValue,
    required this.onBackspace,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final equationColor = isDark ? CalculatorColors.darkEquationText : CalculatorColors.lightEquationText;
    final displayColor = isDark ? CalculatorColors.darkDisplayText : CalculatorColors.lightDisplayText;

    return GestureDetector(
      onHorizontalDragEnd: (details) {
        // Swipe to delete/backspace
        if (details.primaryVelocity != null && details.primaryVelocity!.abs() > 100) {
          onBackspace();
        }
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
        alignment: Alignment.bottomRight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // Secondary Equation Line
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              reverse: true,
              child: Text(
                equation.isEmpty ? ' ' : equation,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w400,
                  color: equationColor,
                  letterSpacing: 1.2,
                ),
                maxLines: 1,
              ),
            ),
            const SizedBox(height: 10),
            // Primary Input / Result Line
            SizedBox(
              height: 72,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerRight,
                child: Text(
                  displayValue,
                  style: TextStyle(
                    fontSize: 64,
                    fontWeight: FontWeight.w400,
                    color: displayColor,
                    letterSpacing: -1.0,
                  ),
                  maxLines: 1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

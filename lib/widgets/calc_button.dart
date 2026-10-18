import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/calculator_theme.dart';

class CalcButton extends StatelessWidget {
  final String? text;
  final IconData? icon;
  final CalcButtonType type;
  final VoidCallback onPressed;
  final bool isSelected;
  final Alignment alignment;

  const CalcButton({
    super.key,
    this.text,
    this.icon,
    this.type = CalcButtonType.number,
    required this.onPressed,
    this.isSelected = false,
    this.alignment = Alignment.center,
  }) : assert(text != null || icon != null, 'Either text or icon must be provided');

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    Color bgColor;
    Color fgColor;

    switch (type) {
      case CalcButtonType.number:
        bgColor = isDark ? CalculatorColors.darkNumBtn : CalculatorColors.lightNumBtn;
        fgColor = isDark ? CalculatorColors.darkNumText : CalculatorColors.lightNumText;
        break;
      case CalcButtonType.utility:
        bgColor = isDark ? CalculatorColors.darkUtilBtn : CalculatorColors.lightUtilBtn;
        fgColor = isDark ? CalculatorColors.darkUtilText : CalculatorColors.lightUtilText;
        break;
      case CalcButtonType.operator:
        bgColor = isSelected
            ? (isDark ? Colors.white : const Color(0xFF1F2937))
            : (isDark ? CalculatorColors.darkOpBtn : CalculatorColors.lightOpBtn);
        fgColor = isSelected
            ? (isDark ? CalculatorColors.darkOpBtn : Colors.white)
            : (isDark ? CalculatorColors.darkOpText : CalculatorColors.lightOpText);
        break;
      case CalcButtonType.equals:
        bgColor = isDark ? CalculatorColors.darkEqualsBtn : CalculatorColors.lightEqualsBtn;
        fgColor = isDark ? CalculatorColors.darkEqualsText : CalculatorColors.lightEqualsText;
        break;
    }

    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Material(
        color: bgColor,
        borderRadius: BorderRadius.circular(24.0),
        child: InkWell(
          borderRadius: BorderRadius.circular(24.0),
          onTap: () {
            HapticFeedback.lightImpact();
            onPressed();
          },
          child: Align(
            alignment: alignment,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: alignment == Alignment.center ? 0 : 28.0,
              ),
              child: text != null
                  ? Text(
                      text!,
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: type == CalcButtonType.number ? FontWeight.w500 : FontWeight.w600,
                        color: fgColor,
                      ),
                    )
                  : Icon(
                      icon,
                      size: 26,
                      color: fgColor,
                    ),
            ),
          ),
        ),
      ),
    );
  }
}

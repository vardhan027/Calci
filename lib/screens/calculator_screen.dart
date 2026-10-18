import 'package:flutter/material.dart';
import '../logic/calculator_engine.dart';
import '../theme/calculator_theme.dart';
import '../widgets/calc_button.dart';
import '../widgets/calc_display.dart';

class CalculatorScreen extends StatefulWidget {
  final VoidCallback onToggleTheme;
  final bool isDarkMode;

  const CalculatorScreen({
    super.key,
    required this.onToggleTheme,
    required this.isDarkMode,
  });

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final CalculatorEngine _engine = CalculatorEngine();

  void _onDigitPressed(String digit) {
    setState(() {
      _engine.inputDigit(digit);
    });
  }

  void _onDecimalPressed() {
    setState(() {
      _engine.inputDecimal();
    });
  }

  void _onOperatorPressed(String op) {
    setState(() {
      _engine.setOperator(op);
    });
  }

  void _onEqualsPressed() {
    setState(() {
      _engine.evaluate();
    });
  }

  void _onClearPressed() {
    setState(() {
      _engine.clear();
    });
  }

  void _onSignPressed() {
    setState(() {
      _engine.toggleSign();
    });
  }

  void _onBackspacePressed() {
    setState(() {
      _engine.backspace();
    });
  }

  @override
  Widget build(BuildContext context) {
    final activeOp = _engine.currentOperator;
    final isClearAll = _engine.displayValue == '0' && _engine.equation.isEmpty;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Calci',
          style: TextStyle(fontWeight: FontWeight.w600, letterSpacing: 0.5),
        ),
        actions: [
          IconButton(
            tooltip: widget.isDarkMode ? 'Switch to Light' : 'Switch to Dark',
            icon: Icon(
              widget.isDarkMode ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
            ),
            onPressed: widget.onToggleTheme,
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Display Area
            Expanded(
              flex: 4,
              child: CalcDisplay(
                equation: _engine.equation,
                displayValue: _engine.displayValue,
                onBackspace: _onBackspacePressed,
              ),
            ),

            const Divider(height: 1, thickness: 0.5),

            // Keypad Grid
            Expanded(
              flex: 6,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                child: Column(
                  children: [
                    // Row 1: Clear, Sign, Backspace, Divide
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: CalcButton(
                              text: isClearAll ? 'AC' : 'C',
                              type: CalcButtonType.utility,
                              onPressed: _onClearPressed,
                            ),
                          ),
                          Expanded(
                            child: CalcButton(
                              text: '±',
                              type: CalcButtonType.utility,
                              onPressed: _onSignPressed,
                            ),
                          ),
                          Expanded(
                            child: CalcButton(
                              icon: Icons.backspace_outlined,
                              type: CalcButtonType.utility,
                              onPressed: _onBackspacePressed,
                            ),
                          ),
                          Expanded(
                            child: CalcButton(
                              text: '÷',
                              type: CalcButtonType.operator,
                              isSelected: activeOp == '÷',
                              onPressed: () => _onOperatorPressed('÷'),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Row 2: 7, 8, 9, Multiply
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: CalcButton(
                              text: '7',
                              onPressed: () => _onDigitPressed('7'),
                            ),
                          ),
                          Expanded(
                            child: CalcButton(
                              text: '8',
                              onPressed: () => _onDigitPressed('8'),
                            ),
                          ),
                          Expanded(
                            child: CalcButton(
                              text: '9',
                              onPressed: () => _onDigitPressed('9'),
                            ),
                          ),
                          Expanded(
                            child: CalcButton(
                              text: '×',
                              type: CalcButtonType.operator,
                              isSelected: activeOp == '×',
                              onPressed: () => _onOperatorPressed('×'),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Row 3: 4, 5, 6, Subtract
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: CalcButton(
                              text: '4',
                              onPressed: () => _onDigitPressed('4'),
                            ),
                          ),
                          Expanded(
                            child: CalcButton(
                              text: '5',
                              onPressed: () => _onDigitPressed('5'),
                            ),
                          ),
                          Expanded(
                            child: CalcButton(
                              text: '6',
                              onPressed: () => _onDigitPressed('6'),
                            ),
                          ),
                          Expanded(
                            child: CalcButton(
                              text: '-',
                              type: CalcButtonType.operator,
                              isSelected: activeOp == '-',
                              onPressed: () => _onOperatorPressed('-'),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Row 4: 1, 2, 3, Add
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: CalcButton(
                              text: '1',
                              onPressed: () => _onDigitPressed('1'),
                            ),
                          ),
                          Expanded(
                            child: CalcButton(
                              text: '2',
                              onPressed: () => _onDigitPressed('2'),
                            ),
                          ),
                          Expanded(
                            child: CalcButton(
                              text: '3',
                              onPressed: () => _onDigitPressed('3'),
                            ),
                          ),
                          Expanded(
                            child: CalcButton(
                              text: '+',
                              type: CalcButtonType.operator,
                              isSelected: activeOp == '+',
                              onPressed: () => _onOperatorPressed('+'),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Row 5: 0 (wide), Decimal, Equals
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: CalcButton(
                              text: '0',
                              alignment: const Alignment(-0.45, 0),
                              onPressed: () => _onDigitPressed('0'),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: CalcButton(
                              text: '.',
                              onPressed: _onDecimalPressed,
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: CalcButton(
                              text: '=',
                              type: CalcButtonType.equals,
                              onPressed: _onEqualsPressed,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

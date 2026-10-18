import 'package:flutter_test/flutter_test.dart';
import 'package:calci/logic/calculator_engine.dart';

void main() {
  late CalculatorEngine engine;

  setUp(() {
    engine = CalculatorEngine();
  });

  group('CalculatorEngine Basic Operations', () {
    test('initial state is 0 with empty equation', () {
      expect(engine.displayValue, '0');
      expect(engine.equation, '');
      expect(engine.isError, false);
    });

    test('inputs digits correctly without leading zeroes', () {
      engine.inputDigit('0');
      expect(engine.displayValue, '0');
      engine.inputDigit('7');
      expect(engine.displayValue, '7');
      engine.inputDigit('5');
      expect(engine.displayValue, '75');
    });

    test('adds numbers correctly', () {
      engine.inputDigit('1');
      engine.inputDigit('2');
      engine.setOperator('+');
      expect(engine.equation, '12 +');
      engine.inputDigit('8');
      engine.evaluate();
      expect(engine.displayValue, '20');
      expect(engine.equation, '12 + 8 =');
    });

    test('subtracts numbers correctly', () {
      engine.inputDigit('2');
      engine.inputDigit('5');
      engine.setOperator('-');
      engine.inputDigit('1');
      engine.inputDigit('0');
      engine.evaluate();
      expect(engine.displayValue, '15');
      expect(engine.equation, '25 - 10 =');
    });

    test('multiplies numbers correctly', () {
      engine.inputDigit('6');
      engine.setOperator('×');
      engine.inputDigit('7');
      engine.evaluate();
      expect(engine.displayValue, '42');
      expect(engine.equation, '6 × 7 =');
    });

    test('divides numbers correctly', () {
      engine.inputDigit('4');
      engine.inputDigit('5');
      engine.setOperator('÷');
      engine.inputDigit('5');
      engine.evaluate();
      expect(engine.displayValue, '9');
      expect(engine.equation, '45 ÷ 5 =');
    });

    test('handles division by zero gracefully with Error', () {
      engine.inputDigit('9');
      engine.setOperator('÷');
      engine.inputDigit('0');
      engine.evaluate();
      expect(engine.displayValue, 'Error');
      expect(engine.isError, true);
    });
  });

  group('CalculatorEngine Edge Cases & Formatting', () {
    test('handles floating point precision (0.1 + 0.2 = 0.3)', () {
      engine.inputDigit('0');
      engine.inputDecimal();
      engine.inputDigit('1');
      engine.setOperator('+');
      engine.inputDigit('0');
      engine.inputDecimal();
      engine.inputDigit('2');
      engine.evaluate();
      expect(engine.displayValue, '0.3');
    });

    test('prevents multiple decimals in single number', () {
      engine.inputDigit('3');
      engine.inputDecimal();
      engine.inputDigit('1');
      engine.inputDecimal();
      engine.inputDigit('4');
      expect(engine.displayValue, '3.14');
    });

    test('handles chained operations sequentially', () {
      engine.inputDigit('5');
      engine.setOperator('+');
      engine.inputDigit('3');
      engine.setOperator('×'); // Should calculate 5 + 3 = 8
      expect(engine.displayValue, '8');
      engine.inputDigit('2');
      engine.evaluate(); // 8 × 2 = 16
      expect(engine.displayValue, '16');
    });

    test('allows changing operator before second operand', () {
      engine.inputDigit('8');
      engine.setOperator('+');
      engine.setOperator('×'); // Changed mind
      expect(engine.equation, '8 ×');
      engine.inputDigit('5');
      engine.evaluate();
      expect(engine.displayValue, '40');
    });

    test('toggleSign flips positive and negative', () {
      engine.inputDigit('4');
      engine.inputDigit('2');
      engine.toggleSign();
      expect(engine.displayValue, '-42');
      engine.toggleSign();
      expect(engine.displayValue, '42');
    });

    test('applyPercent divides by 100', () {
      engine.inputDigit('5');
      engine.inputDigit('0');
      engine.applyPercent();
      expect(engine.displayValue, '0.5');
    });

    test('backspace deletes last digit and resets to 0 when empty', () {
      engine.inputDigit('1');
      engine.inputDigit('2');
      engine.backspace();
      expect(engine.displayValue, '1');
      engine.backspace();
      expect(engine.displayValue, '0');
    });

    test('clear resets all state', () {
      engine.inputDigit('9');
      engine.setOperator('+');
      engine.inputDigit('1');
      engine.clear();
      expect(engine.displayValue, '0');
      expect(engine.equation, '');
      expect(engine.currentOperator, null);
    });
  });
}

class CalculatorEngine {
  String _displayValue = '0';
  String _equation = '';
  double? _firstOperand;
  String? _operator;
  bool _shouldResetInput = false;
  bool _isError = false;

  String get displayValue => _displayValue;
  String get equation => _equation;
  String? get currentOperator => _operator;
  bool get isError => _isError;

  void inputDigit(String digit) {
    if (_isError) {
      clear();
    }

    if (_shouldResetInput) {
      _displayValue = digit;
      _shouldResetInput = false;
      return;
    }

    if (_displayValue == '0') {
      _displayValue = digit;
    } else {
      // Prevent excessively long inputs that overflow display
      if (_displayValue.replaceAll('-', '').replaceAll('.', '').length >= 12) {
        return;
      }
      _displayValue += digit;
    }
  }

  void inputDecimal() {
    if (_isError) {
      clear();
    }

    if (_shouldResetInput) {
      _displayValue = '0.';
      _shouldResetInput = false;
      return;
    }

    if (!_displayValue.contains('.')) {
      _displayValue += '.';
    }
  }

  void setOperator(String op) {
    if (_isError) return;

    final currentValue = double.tryParse(_displayValue);
    if (currentValue == null) return;

    // If an operator is already active and user entered a second operand, calculate intermediate
    if (_firstOperand != null && _operator != null && !_shouldResetInput) {
      final intermediate = _calculate(_firstOperand!, currentValue, _operator!);
      if (intermediate == null) {
        _handleDivisionByZero(_firstOperand!, 0);
        return;
      }
      _firstOperand = intermediate;
      _displayValue = _formatNumber(intermediate);
    } else {
      _firstOperand = currentValue;
    }

    _operator = op;
    _equation = '${_formatNumber(_firstOperand!)} $op';
    _shouldResetInput = true;
  }

  void evaluate() {
    if (_isError || _operator == null || _firstOperand == null) return;

    final secondOperand = double.tryParse(_displayValue);
    if (secondOperand == null) return;

    if (_operator == '÷' && secondOperand == 0) {
      _handleDivisionByZero(_firstOperand!, secondOperand);
      return;
    }

    final result = _calculate(_firstOperand!, secondOperand, _operator!);
    if (result == null) {
      _handleDivisionByZero(_firstOperand!, secondOperand);
      return;
    }

    _equation = '${_formatNumber(_firstOperand!)} $_operator ${_formatNumber(secondOperand)} =';
    _displayValue = _formatNumber(result);
    _firstOperand = null;
    _operator = null;
    _shouldResetInput = true;
  }

  void toggleSign() {
    if (_isError || _displayValue == '0') return;

    if (_displayValue.startsWith('-')) {
      _displayValue = _displayValue.substring(1);
    } else {
      _displayValue = '-$_displayValue';
    }
  }

  void applyPercent() {
    if (_isError) return;

    final value = double.tryParse(_displayValue);
    if (value == null) return;

    final percentValue = value / 100.0;
    _displayValue = _formatNumber(percentValue);
    _shouldResetInput = true;
  }

  void backspace() {
    if (_isError) {
      clear();
      return;
    }

    if (_shouldResetInput) return;

    if (_displayValue.length > 1) {
      // If it's a negative single digit like "-5", reset to "0"
      if (_displayValue.length == 2 && _displayValue.startsWith('-')) {
        _displayValue = '0';
      } else {
        _displayValue = _displayValue.substring(0, _displayValue.length - 1);
        if (_displayValue.isEmpty || _displayValue == '-') {
          _displayValue = '0';
        }
      }
    } else {
      _displayValue = '0';
    }
  }

  void clear() {
    _displayValue = '0';
    _equation = '';
    _firstOperand = null;
    _operator = null;
    _shouldResetInput = false;
    _isError = false;
  }

  double? _calculate(double a, double b, String op) {
    switch (op) {
      case '+':
        return a + b;
      case '-':
        return a - b;
      case '×':
        return a * b;
      case '÷':
        if (b == 0) return null;
        return a / b;
      default:
        return null;
    }
  }

  void _handleDivisionByZero(double a, double b) {
    _equation = '${_formatNumber(a)} ÷ ${_formatNumber(b)} =';
    _displayValue = 'Error';
    _isError = true;
    _firstOperand = null;
    _operator = null;
    _shouldResetInput = true;
  }

  String _formatNumber(double number) {
    if (number.isInfinite || number.isNaN) return 'Error';

    // Avoid floating point precision display glitches (e.g. 0.1 + 0.2 = 0.30000000000000004)
    String str = double.parse(number.toStringAsPrecision(10)).toString();

    // Check if integer (e.g. 5.0 -> 5)
    if (str.endsWith('.0')) {
      str = str.substring(0, str.length - 2);
    } else if (str.contains('.')) {
      // Strip trailing zeroes after decimal
      str = str.replaceAll(RegExp(r'0+$'), '');
      if (str.endsWith('.')) {
        str = str.substring(0, str.length - 1);
      }
    }
    return str;
  }
}

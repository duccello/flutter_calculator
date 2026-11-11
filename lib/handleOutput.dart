import 'handleInput.dart';

String solve() {
  String expr = inputString;

  while (expr.length > 1 && '+-*/.'.contains(expr[expr.length - 1])) {
    expr = expr.substring(0, expr.length - 1);
  }
  if (expr == '-') return '0';

  try {
    final result = _Parser(expr).parse();
    return _format(result);
  } catch (e) {
    return 'Error';
  }
}

String _format(double v) {
  if (v.isNaN || v.isInfinite) return 'Error';
  if (v == v.truncateToDouble() && v.abs() < 1e15) return v.toInt().toString();
  String s = v.toStringAsFixed(10);
  s = s.replaceFirst(RegExp(r'0+$'), '');
  s = s.replaceFirst(RegExp(r'\.$'), '');
  return s;
}

class _Parser {
  final String s;
  int pos = 0;
  _Parser(this.s);

  double parse() {
    final v = _expression();
    if (pos != s.length) throw FormatException('Unexpected character');
    return v;
  }

  double _expression() {
    double v = _term();
    while (pos < s.length && (s[pos] == '+' || s[pos] == '-')) {
      final op = s[pos++];
      final r = _term();
      v = op == '+' ? v + r : v - r;
    }
    return v;
  }

  double _term() {
    double v = _factor();
    while (pos < s.length && (s[pos] == '*' || s[pos] == '/')) {
      final op = s[pos++];
      final r = _factor();
      if (op == '/' && r == 0) throw FormatException('Division by zero');
      v = op == '*' ? v * r : v / r;
    }
    return v;
  }

  double _factor() {
    if (pos < s.length && s[pos] == '-') {
      pos++;
      return -_factor();
    }
    final start = pos;
    while (pos < s.length && RegExp(r'[0-9.]').hasMatch(s[pos])) {
      pos++;
    }
    if (start == pos) throw FormatException('Number expected');
    return double.parse(s.substring(start, pos));
  }
}

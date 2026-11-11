String inputString = '0';
String outputString = '0';

const String operators = '+-*/';

String handleNumber(String c) {
  if (inputString == '0' && c == '00') return '0';
  if (inputString == '0') return c;
  return inputString + c;
}

String handleSign(String c) {

  if (inputString == '0') {
    return c == '-' ? c : inputString + c;
  }
  String last = inputString[inputString.length - 1];
  if (operators.contains(last) || last == '.') return inputString;
  return inputString + c;
}

String handleDot() {
  String last = inputString[inputString.length - 1];

  if (operators.contains(last)) return inputString + '0.';

  int lastOp = -1;
  for (int i = 1; i < inputString.length; i++) {
    if (operators.contains(inputString[i])) lastOp = i;
  }
  if (inputString.substring(lastOp + 1).contains('.')) return inputString;

  return inputString + '.';
}

String handleCleaner() {
  if (inputString.length <= 1) return '0';
  return inputString.substring(0, inputString.length - 1);
}

void handleAC() {
  inputString = '0';
  outputString = '0';
}

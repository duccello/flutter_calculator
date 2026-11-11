import 'package:flutter/material.dart';
import 'handleInput.dart';
import 'handleOutput.dart';

void main() => runApp(MaterialApp(
      home: Home(),
    ));

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<List<String>> buttonLayout = [
    ['7', '8', '9', 'C', 'AC'],
    ['4', '5', '6', '+', '-'],
    ['1', '2', '3', '*', '/'],
    ['0', '.', '00', '=', ' '],
  ];

  void _onButtonPressed(String label) {
    setState(() {
      switch (label) {
        case 'AC':
          handleAC();
          break;
        case 'C':
          inputString = handleCleaner();
          break;
        case '=':
          outputString = solve();
          break;
        case '+':
        case '-':
        case '*':
        case '/':
          inputString = handleSign(label);
          break;
        case '.':
          inputString = handleDot();
          break;
        case ' ':
          break;
        default:
          inputString = handleNumber(label);
      }
    });
  }

  Color? _textColor(String label) {
    if (label == 'C' || label == 'AC') return Colors.red[600];
    if ('+-*/='.contains(label)) return Colors.white;
    return null;
  }

  Widget _buildButton(String label) {
    return Expanded(
      child: TextButton(
        onPressed: () => _onButtonPressed(label),
        child: Text(label, style: TextStyle(color: _textColor(label))),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
        centerTitle: true,
        backgroundColor: Colors.indigo[300],
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              color: Colors.indigo[100],
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      inputString,
                      style:
                          TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      outputString,
                      style:
                          TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            color: Colors.indigo[300],
            child: Column(
              children: buttonLayout
                  .map((row) => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: row.map(_buildButton).toList(),
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

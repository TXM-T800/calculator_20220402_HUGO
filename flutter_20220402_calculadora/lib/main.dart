import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Calculator',
      theme: ThemeData.light(),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late String _input = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          _buildResultDisplay(),
          const SizedBox(height: 16),
          _buildCalculatorButtons(),
        ],
      ),
    );
  }

  Widget _buildResultDisplay() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      alignment: Alignment.bottomRight,
      child: Text(
        _input.isEmpty ? '0' : _input,
        style: const TextStyle(fontSize: 40),
      ),
    );
  }

  Widget _buildCalculatorButtons() {
    return Expanded(
      child: Container(
        color: Colors.grey[200],
        child: Column(
          children: [
            _buildButtonRow(['C', '+/-', '%', '/']),
            _buildButtonRow(['7', '8', '9', '*']),
            _buildButtonRow(['4', '5', '6', '-']),
            _buildButtonRow(['1', '2', '3', '+']),
            _buildButtonRow(['0', '.', '=']),
          ],
        ),
      ),
    );
  }

  Widget _buildButtonRow(List<String> buttons) {
    return Expanded(
      child: Row(
        children: buttons
            .map(
              (button) => Expanded(
                child: GestureDetector(
                  onTap: () => _onButtonPressed(button),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: Center(
                      child: Text(
                        button,
                        style: const TextStyle(fontSize: 24),
                      ),
                    ),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  void _onButtonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        _input = '';
      } else if (buttonText == '=') {
        _calculateResult();
      } else {
        _input += buttonText;
      }
    });
  }

  void _calculateResult() {
    try {
      // Evaluando la expresión y devolviendo el resultado directamente
      // Si ocurre un error durante la evaluación, establecer el resultado en 'Error'
      Parser p = Parser();
      Expression exp = p.parse(_input);
      double result = exp.evaluate(EvaluationType.REAL, ContextModel());

      // Convirtiendo el resultado a una cadena con tres dígitos decimales
      String strResult = result.toStringAsFixed(0);

      // Asignando el resultado a la variable input
      _input = strResult;
    } catch (e) {
      _input = 'Hola';
    }
  }
}

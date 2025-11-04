import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String input = "";
  String output = "0";

  buttonPressed(String value) {
    setState(() {
      if (value == "C") {
        input = "";
        output = "0";
      } else if (value == "DEL") {
        input = input.isNotEmpty ? input.substring(0, input.length - 1) : "";
      } else if (value == "=") {
        try {
          Parser parser = Parser();
          Expression expression = parser.parse(input.replaceAll('×', '*').replaceAll('÷', '/'));
          ContextModel contextModel = ContextModel();
          double eval = expression.evaluate(EvaluationType.REAL, contextModel);
          output = eval.toString();
        } catch (e) {
          output = "Error";
        }
      } else {
        input += value;
      }
    });
  }

  Widget calculatorButton(String text, {Color? color}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 22),
            backgroundColor: color ?? Colors.grey[850],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: () => buttonPressed(text),
          child: Text(
            text,
            style: const TextStyle(fontSize: 22, color: Colors.white),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20),
              alignment: Alignment.bottomRight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    input,
                    style: const TextStyle(fontSize: 31, color: Colors.white70),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    output,
                    style: const TextStyle(fontSize: 48, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),

          // Buttons
          Row(
            children: [
              calculatorButton("C", color: Colors.red),
              calculatorButton("DEL", color: Colors.orange),
              calculatorButton("%", color: Colors.orange),
              calculatorButton("÷", color: Colors.orange),
            ],
          ),
          Row(
            children: [
              calculatorButton("7"),
              calculatorButton("8"),
              calculatorButton("9"),
              calculatorButton("×", color: Colors.orange),
            ],
          ),
          Row(
            children: [
              calculatorButton("4"),
              calculatorButton("5"),
              calculatorButton("6"),
              calculatorButton("-", color: Colors.orange),
            ],
          ),
          Row(
            children: [
              calculatorButton("1"),
              calculatorButton("2"),
              calculatorButton("3"),
              calculatorButton("+", color: Colors.orange),
            ],
          ),
          Row(
            children: [
              calculatorButton("0"),
              calculatorButton("."),
              calculatorButton("=",
                  color: Colors.green
              ),
            ],
          ),
        ],
      ),
    );
  }
}

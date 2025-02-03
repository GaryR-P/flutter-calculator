import 'package:flutter/material.dart';
import 'package:expressions/expressions.dart'; // External package for expression evaluation

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
        home: MyHomePage(title: "Calculator"),
      );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _expression = "";
  String _result = "";

  void _onButtonPressed(String value) {
    setState(() {
      if (value == "C") {
        _expression = "";
        _result = "";
      } else if (value == "=") {
        try {
          final expression = Expression.parse(_expression);
          final evaluator = const ExpressionEvaluator();
          _result = evaluator.eval(expression, {}).toString();
        } catch (e) {
          _result = "Error";
        }
      } else {
        _expression += value;
      }
    });
  }

  Widget _buildButton(String text) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () => _onButtonPressed(text),
        child: Text(text, style: const TextStyle(fontSize: 24)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              alignment: Alignment.centerRight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _expression,
                    style: const TextStyle(fontSize: 32),
                  ),
                  Text(
                    _result,
                    style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          Column(
            children: [
              ["7", "8", "9", "/"],
              ["4", "5", "6", "*"],
              ["1", "2", "3", "-"],
              ["C", "0", "=", "+"],
            ].map((row) {
              return Row(
                children: row.map(_buildButton).toList(),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
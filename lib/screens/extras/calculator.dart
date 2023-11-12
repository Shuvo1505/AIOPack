import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';

void main() {
  runApp(const CalculatorScreen());
}

class CalculatorScreen extends StatelessWidget {
  const CalculatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AIOPack',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true),
      home: const CalculatorPage(),
    );
  }
}

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  late String _output = "";
  late String _currentInput = "";
  late String tempInput = "";
  late List<String> _history = [];

  static const String outputKey = "output_key_calcu";
  static const String inputKey = "input_key_calcu";
  static const String historyKey = "history_key_calcu";

  @override
  void initState() {
    loadGeneratedData();
    super.initState();
  }

  void _onButtonPressed(String buttonText) {
    setState(() {
      if (buttonText == "=") {
        try {
          _output = _evaluateExpression(_currentInput);
          _addToHistory("$_currentInput = $_output");
          storeGeneratedData();
        } catch (e) {
          _output = "ERROR";
        }
      } else if (buttonText == "C") {
        _currentInput = "";
        _output = "";
        storeGeneratedData();
      } else if (buttonText == "B") {
        _currentInput = _currentInput.substring(0, _currentInput.length - 1);
      } else if (buttonText == "√") {
        _currentInput = "sqrt($_currentInput)";
      } else if (buttonText == "%") {
        _currentInput += "%";
      } else {
        _currentInput += buttonText;
      }
    });
  }

  String _evaluateExpression(String expression) {
    expression = expression.replaceAll("%", "/100");
    Parser p = Parser();
    ContextModel cm = ContextModel();
    Expression exp = p.parse(expression);
    double result = exp.evaluate(EvaluationType.REAL, cm);
    return result.toString();
  }

  void _addToHistory(String expression) {
    setState(() {
      _history.add(expression);
    });
  }

  void _openHistoryPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            HistoryPage(history: _history, clearHistoryCallback: clearHistory),
      ),
    );
  }

  void clearHistory() {
    setState(() {
      _history.clear();
      storeGeneratedData();
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.height;
    final aspect = screenWidth / 556;
    return Scaffold(
        backgroundColor: HexColor("#050A0C"),
        appBar: AppBar(
          leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_sharp,
                  color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              }),
          actions: [
            IconButton(
              icon: const Icon(Icons.history),
              onPressed: () {
                _openHistoryPage(context);
              },
            ),
          ],
          backgroundColor: HexColor("#050A0C"),
          centerTitle: true,
          title: const Text("Basic Calculator",
              style: TextStyle(fontWeight: FontWeight.w300)),
          toolbarHeight: 90,
        ),
        body: Container(
            height: context.screenHeight,
            width: context.screenWidth,
            color: HexColor("#050A0C"),
            child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 10),
                      SizedBox(
                        width: context.screenWidth,
                        height: (context.screenHeight) / 3.8,
                        child: RawScrollbar(
                          thumbColor: HexColor("#ff4f00"),
                          thumbVisibility: true,
                          thickness: 4,
                          radius: const Radius.circular(8),
                          child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Column(children: [
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 20.0),
                                    child: Text(
                                      _currentInput,
                                      textAlign: TextAlign.end,
                                      style: const TextStyle(
                                          fontSize: 24.0,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 30),
                                Visibility(
                                  visible: _output.isEmpty ? false : true,
                                  child: const Divider(
                                    thickness: 2,
                                    color: Colors.white,
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 30.0),
                                    child: Text(_output,
                                        style: const TextStyle(
                                          fontSize: 24.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                        textAlign: TextAlign.end),
                                  ),
                                )
                              ])),
                        ),
                      ),
                      const SizedBox(height: 120),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: GridView.builder(
                            shrinkWrap: true,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 4,
                                    childAspectRatio: aspect),
                            itemCount: _buttonLabels.length,
                            itemBuilder: (context, index) {
                              return ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      enableFeedback: true,
                                      side: const BorderSide(
                                          color: Colors.black, width: 2.0),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                      backgroundColor: HexColor("#e50914")),
                                  onPressed: () {
                                    _onButtonPressed(_buttonLabels[index]);
                                  },
                                  child: Text(_buttonLabels[index],
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 30,
                                      )));
                            }),
                      )
                    ]))));
  }

  final List<String> _buttonLabels = [
    "C",
    "√",
    "%",
    "B",
    "7",
    "8",
    "9",
    "/",
    "4",
    "5",
    "6",
    "*",
    "1",
    "2",
    "3",
    "-",
    "0",
    ".",
    "=",
    "+"
  ];

  Future<void> loadGeneratedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _currentInput = prefs.getString(inputKey) ?? "";
      _output = prefs.getString(outputKey) ?? "";
      _history = prefs.getStringList(historyKey) ?? [];
    });
  }

  Future<void> storeGeneratedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(inputKey, _currentInput);
    prefs.setString(outputKey, _output);
    prefs.setStringList(historyKey, _history);
  }
}

class HistoryPage extends StatelessWidget {
  final List<String> history;
  final VoidCallback clearHistoryCallback;

  const HistoryPage(
      {super.key, required this.history, required this.clearHistoryCallback});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: HexColor("#050A0C"),
        appBar: AppBar(
          leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_sharp,
                  color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              }),
          actions: [
            Visibility(
              visible: history.isEmpty ? false : true,
              child: IconButton(
                  onPressed: () {
                    clearHistoryCallback();
                  },
                  icon: const Icon(Icons.delete_forever, color: Colors.white)),
            )
          ],
          backgroundColor: HexColor("#050A0C"),
          centerTitle: true,
          title: const Text("Calculation History",
              style: TextStyle(fontWeight: FontWeight.w300)),
          toolbarHeight: 90,
        ),
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const SizedBox(height: 20),
          Visibility(
              visible: history.isEmpty ? true : false,
              child: Column(
                children: [
                  Center(
                    child: AnimatedOpacity(
                      duration: const Duration(seconds: 3),
                      opacity: history.isEmpty ? 1.0 : 0.0,
                      child: const Icon(
                        Icons.history,
                        color: Colors.grey,
                        size: 60,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: AnimatedOpacity(
                      duration: const Duration(seconds: 3),
                      opacity: history.isEmpty ? 1.0 : 0.0,
                      child: const Text(
                        "No History",
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 20,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Center(
                    child: AnimatedOpacity(
                      duration: const Duration(seconds: 3),
                      opacity: history.isEmpty ? 1.0 : 0.0,
                      child: const Text(
                        "As you start calculation, Your\nhistory will appear here.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 20,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: AnimatedOpacity(
                        duration: const Duration(seconds: 3),
                        opacity: history.isEmpty ? 1.0 : 0.0,
                        child: SizedBox(
                          height: 40,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: HexColor("#e50914"),
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(20.0)))),
                            child: const Text(
                              "Start calculation",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                        )),
                  ),
                ],
              )),
          Visibility(
              visible: history.isEmpty ? false : true,
              child: Expanded(
                  child: ListView.builder(
                      itemCount: history.length,
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: HexColor("#45494c"),
                          ),
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 10.0),
                          child: ListTile(
                              title: Text(history[index],
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 18))),
                        );
                      })))
        ]));
  }
}

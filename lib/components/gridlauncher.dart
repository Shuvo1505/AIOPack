import 'package:aiopack/screens/extras/compass.dart';
import 'package:aiopack/screens/extras/cryptography.dart';
import 'package:aiopack/screens/extras/emicalculator.dart';
import 'package:aiopack/screens/extras/interestrate.dart';
import 'package:aiopack/screens/extras/passwordgenerator.dart';
import 'package:aiopack/screens/extras/qrgenerator.dart';
import 'package:aiopack/screens/extras/qrscanner.dart';
import 'package:aiopack/screens/extras/stopwatch.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../screens/extras/calculator.dart';

void main() {
  runApp(const ExtrasScreen());
}

class ExtrasScreen extends StatelessWidget {
  const ExtrasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AIOPack',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ExtrasPage(
        title: 'Essential Tools',
      ),
    );
  }
}

class ExtrasPage extends StatefulWidget {
  const ExtrasPage({super.key, required this.title});

  final String title;

  @override
  State<ExtrasPage> createState() => _ExtrasPageState();
}

class _ExtrasPageState extends State<ExtrasPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.close_sharp, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: HexColor("#050A0C"),
          centerTitle: true,
          title: Text(widget.title,
              style: const TextStyle(fontWeight: FontWeight.w300)),
          toolbarHeight: 90,
        ),
        body: Container(
            width: double.infinity,
            height: double.infinity,
            color: HexColor("#050A0C"),
            child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: GridView(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 20,
                            crossAxisSpacing: 20),
                    children: [
                      InkWell(
                        enableFeedback: true,
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const CalculatorPage()));
                        },
                        child: Container(
                            height: 10,
                            width: 10,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                color: HexColor("#1f1f1f")),
                            child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Image.asset(
                                    "assets/images/calculator.png",
                                    height: 64,
                                    width: 64,
                                  ),
                                  const Text("Calculator",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16))
                                ])),
                      ),
                      InkWell(
                        enableFeedback: true,
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const CompassPage()));
                        },
                        child: Container(
                            height: 10,
                            width: 10,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                color: HexColor("#1f1f1f")),
                            child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Image.asset(
                                    "assets/images/compass.png",
                                    height: 64,
                                    width: 64,
                                  ),
                                  const Text("Compass",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16))
                                ])),
                      ),
                      InkWell(
                        enableFeedback: true,
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const CryptoPage()));
                        },
                        child: Container(
                            height: 10,
                            width: 10,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                color: HexColor("#1f1f1f")),
                            child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Image.asset(
                                    "assets/images/crypto.png",
                                    height: 64,
                                    width: 64,
                                  ),
                                  const Text("Cryptography",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16))
                                ])),
                      ),
                      InkWell(
                        enableFeedback: true,
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const EMIPage()));
                        },
                        child: Container(
                            height: 10,
                            width: 10,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                color: HexColor("#1f1f1f")),
                            child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Image.asset(
                                    "assets/images/emi.png",
                                    height: 64,
                                    width: 64,
                                  ),
                                  const Text("EMI Calculator",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16))
                                ])),
                      ),
                      InkWell(
                        enableFeedback: true,
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const InterestPage()));
                        },
                        child: Container(
                            height: 10,
                            width: 10,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                color: HexColor("#1f1f1f")),
                            child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Image.asset(
                                    "assets/images/interest.png",
                                    height: 64,
                                    width: 64,
                                  ),
                                  const Text("Interest Rate",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16))
                                ])),
                      ),
                      InkWell(
                          enableFeedback: true,
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const PasswordPage()));
                          },
                          child: Container(
                              height: 10,
                              width: 10,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                  color: HexColor("#1f1f1f")),
                              child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Image.asset(
                                      "assets/images/passgen.png",
                                      height: 64,
                                      width: 64,
                                    ),
                                    const Text("Passwords",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 16))
                                  ]))),
                      InkWell(
                          enableFeedback: true,
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const QRScanPage()));
                          },
                          child: Container(
                              height: 10,
                              width: 10,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                  color: HexColor("#1f1f1f")),
                              child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Image.asset(
                                      "assets/images/qr-scan.png",
                                      height: 64,
                                      width: 64,
                                    ),
                                    const Text("QR Scanner",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 16))
                                  ]))),
                      InkWell(
                          enableFeedback: true,
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const QRGeneratorPage()));
                          },
                          child: Container(
                              height: 10,
                              width: 10,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                  color: HexColor("#1f1f1f")),
                              child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Image.asset(
                                      "assets/images/qr-edit.png",
                                      height: 64,
                                      width: 64,
                                    ),
                                    const Text("QR Generator",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 16))
                                  ]))),
                      InkWell(
                          enableFeedback: true,
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const StopwatchPage()));
                          },
                          child: Container(
                              height: 10,
                              width: 10,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                  color: HexColor("#1f1f1f")),
                              child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Image.asset(
                                      "assets/images/stopwatch.png",
                                      height: 64,
                                      width: 64,
                                    ),
                                    const Text("Stopwatch",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 16))
                                  ])))
                    ]))));
  }
}

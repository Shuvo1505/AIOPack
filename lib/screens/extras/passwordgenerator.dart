import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:velocity_x/velocity_x.dart';

void main() {
  runApp(const PasswordScreen());
}

class PasswordScreen extends StatelessWidget {
  const PasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AIOPack',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const PasswordPage(),
    );
  }
}

class PasswordPage extends StatefulWidget {
  const PasswordPage({super.key});

  @override
  State<PasswordPage> createState() => _PasswordPageState();
}

class _PasswordPageState extends State<PasswordPage> {
  late int passlength = 20;
  late bool uppercase = false;
  late bool lowercase = false;
  late bool numbers = false;
  late bool symbols = false;
  late bool passwordnotComplex = false;

  late String genPass = "";

  final Random random = Random();

  notifySuccess(String message) {
    Fluttertoast.showToast(
        msg: message,
        gravity: ToastGravity.TOP,
        toastLength: Toast.LENGTH_SHORT,
        fontSize: 16.0,
        backgroundColor: Colors.green,
        textColor: Colors.white);
  }

  void _updateLength(double value) {
    setState(() {
      passlength = value.toInt();
      if (passlength < 20) {
        passwordnotComplex = true;
      } else {
        passwordnotComplex = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  showPop();
                },
                icon:
                    const Icon(Icons.info_outline_rounded, color: Colors.white))
          ],
          leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_sharp,
                  color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              }),
          backgroundColor: HexColor("#050A0C"),
          centerTitle: true,
          title: const Text("Password Generator",
              style: TextStyle(fontWeight: FontWeight.w300)),
          toolbarHeight: 90,
        ),
        body: Container(
            width: double.infinity,
            height: double.infinity,
            color: HexColor("#050A0C"),
            child: SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Container(
                                margin: const EdgeInsets.all(12.0),
                                child: const Text("Choose Password Length",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold))),
                          ),
                          const SizedBox(height: 10),
                          SliderTheme(
                            data: SliderThemeData(
                                thumbShape: const RoundSliderThumbShape(
                                  enabledThumbRadius: 12,
                                ),
                                activeTrackColor: passwordnotComplex == true
                                    ? HexColor("#e50914")
                                    : HexColor("#028A0F"),
                                trackHeight: 20.0,
                                inactiveTrackColor: Colors.grey,
                                thumbColor: HexColor("#FFA500"),
                                overlayColor: Colors.transparent),
                            child: Slider(
                                value: passlength.toDouble(),
                                min: 8,
                                max: 50,
                                onChanged: _updateLength),
                          ),
                          Center(
                              child: Text(passlength.toStringAsFixed(0),
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 20))),
                          const SizedBox(height: 10),
                          Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 12.0),
                              child: const Text("Password Contains (Only)",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold))),
                          Column(children: [
                            Row(children: [
                              Checkbox(
                                  activeColor: HexColor("#e50914"),
                                  checkColor: Colors.white,
                                  value: uppercase,
                                  side: BorderSide(color: HexColor("#e50914")),
                                  onChanged: (value) {
                                    setState(() {
                                      uppercase = value!;
                                      if (value) {
                                        lowercase = false;
                                        numbers = false;
                                        symbols = false;
                                      }
                                    });
                                  }),
                              const Text("Uppercase",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16))
                            ]),
                            Row(children: [
                              Checkbox(
                                  activeColor: HexColor("#e50914"),
                                  checkColor: Colors.white,
                                  value: lowercase,
                                  side: BorderSide(color: HexColor("#e50914")),
                                  onChanged: (value) {
                                    setState(() {
                                      lowercase = value!;
                                      if (value) {
                                        uppercase = false;
                                        numbers = false;
                                        symbols = false;
                                      }
                                    });
                                  }),
                              const Text("Lowercase",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16))
                            ]),
                            Row(children: [
                              Checkbox(
                                  activeColor: HexColor("#e50914"),
                                  checkColor: Colors.white,
                                  side: BorderSide(color: HexColor("#e50914")),
                                  value: numbers,
                                  onChanged: (value) {
                                    setState(() {
                                      numbers = value!;
                                      if (value) {
                                        uppercase = false;
                                        lowercase = false;
                                        symbols = false;
                                      }
                                    });
                                  }),
                              const Text("Numbers",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16))
                            ]),
                            Row(children: [
                              Checkbox(
                                  activeColor: HexColor("#e50914"),
                                  checkColor: Colors.white,
                                  side: BorderSide(color: HexColor("#e50914")),
                                  value: symbols,
                                  onChanged: (value) {
                                    setState(() {
                                      symbols = value!;
                                      if (value) {
                                        uppercase = false;
                                        lowercase = false;
                                        numbers = false;
                                      }
                                    });
                                  }),
                              const Text("Symbols",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16))
                            ])
                          ]),
                          const SizedBox(height: 20),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                SizedBox(
                                  width: 140,
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: HexColor("#e50914"),
                                          shape: ContinuousRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20.0))),
                                      onPressed: () {
                                        if (uppercase == true) {
                                          genWithUpper();
                                          showModalBottomSheet(
                                              context: context,
                                              isScrollControlled: true,
                                              backgroundColor:
                                                  HexColor("#050A0C"),
                                              builder: (BuildContext context) {
                                                return SizedBox(
                                                  height: 270,
                                                  child: Card(
                                                    elevation: 0,
                                                    color: HexColor("#1f1f1f"),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        16),
                                                            side: BorderSide
                                                                .none),
                                                    child:
                                                        buildBottomSheetContent(
                                                            context),
                                                  ),
                                                );
                                              });
                                        }
                                        if (lowercase == true) {
                                          genWithLower();
                                          showModalBottomSheet(
                                              context: context,
                                              isScrollControlled: true,
                                              backgroundColor:
                                                  HexColor("#050A0C"),
                                              builder: (BuildContext context) {
                                                return SizedBox(
                                                  height: 270,
                                                  child: Card(
                                                    elevation: 0,
                                                    color: HexColor("#1f1f1f"),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        16),
                                                            side: BorderSide
                                                                .none),
                                                    child:
                                                        buildBottomSheetContent(
                                                            context),
                                                  ),
                                                );
                                              });
                                        }
                                        if (numbers == true) {
                                          genWithNumber();
                                          showModalBottomSheet(
                                              context: context,
                                              isScrollControlled: true,
                                              backgroundColor:
                                                  HexColor("#050A0C"),
                                              builder: (BuildContext context) {
                                                return SizedBox(
                                                  height: 270,
                                                  child: Card(
                                                    elevation: 0,
                                                    color: HexColor("#1f1f1f"),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        16),
                                                            side: BorderSide
                                                                .none),
                                                    child:
                                                        buildBottomSheetContent(
                                                            context),
                                                  ),
                                                );
                                              });
                                        }
                                        if (symbols == true) {
                                          genWithSymbol();
                                          showModalBottomSheet(
                                              context: context,
                                              isScrollControlled: true,
                                              backgroundColor:
                                                  HexColor("#050A0C"),
                                              builder: (BuildContext context) {
                                                return SizedBox(
                                                  height: 270,
                                                  child: Card(
                                                    elevation: 0,
                                                    color: HexColor("#1f1f1f"),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        16),
                                                            side: BorderSide
                                                                .none),
                                                    child:
                                                        buildBottomSheetContent(
                                                            context),
                                                  ),
                                                );
                                              });
                                        }
                                        if (uppercase == false &&
                                            lowercase == false &&
                                            numbers == false &&
                                            symbols == false) {
                                          genWithAll();
                                          showModalBottomSheet(
                                              context: context,
                                              isScrollControlled: true,
                                              backgroundColor:
                                                  HexColor("#050A0C"),
                                              builder: (BuildContext context) {
                                                return SizedBox(
                                                  height: 270,
                                                  child: Card(
                                                    elevation: 0,
                                                    color: HexColor("#1f1f1f"),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        16),
                                                            side: BorderSide
                                                                .none),
                                                    child:
                                                        buildBottomSheetContent(
                                                            context),
                                                  ),
                                                );
                                              });
                                        }
                                      },
                                      child: const Text("Generate",
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white))),
                                ),
                                SizedBox(
                                  width: 140,
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: HexColor("#e50914"),
                                          shape: ContinuousRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20.0))),
                                      onPressed: () {
                                        setState(() {
                                          uppercase = false;
                                          lowercase = false;
                                          numbers = false;
                                          symbols = false;
                                          passlength = 20;
                                          passwordnotComplex = false;
                                        });
                                      },
                                      child: const Text("Reset",
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white))),
                                )
                              ])
                        ])))));
  }

  void copyMessageContent() {
    Clipboard.setData(ClipboardData(text: genPass));
    notifySuccess("✓ Copied");
  }

  void genWithUpper() {
    const String rawData = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    String result = "";
    for (int i = 0; i < passlength; i++) {
      int randomIndex = random.nextInt(rawData.length);
      result += rawData[randomIndex];
    }
    setState(() {
      genPass = result;
    });
  }

  void genWithLower() {
    const String rawData = "abcdefghijklmnopqrstuvwxyz";
    String result = "";
    for (int i = 0; i < passlength; i++) {
      int randomIndex = random.nextInt(rawData.length);
      result += rawData[randomIndex];
    }
    setState(() {
      genPass = result;
    });
  }

  void genWithNumber() {
    const String rawData = "1234567890";
    String result = "";
    for (int i = 0; i < passlength; i++) {
      int randomIndex = random.nextInt(rawData.length);
      result += rawData[randomIndex];
    }
    setState(() {
      genPass = result;
    });
  }

  void genWithSymbol() {
    const String rawData = "!@#\$%^&*()_-+=<>?/[]{}|";
    String result = "";
    for (int i = 0; i < passlength; i++) {
      int randomIndex = random.nextInt(rawData.length);
      result += rawData[randomIndex];
    }
    setState(() {
      genPass = result;
    });
  }

  void genWithAll() {
    const String rawData =
        "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
        "1234567890!@#\$%^&*()_-+=<>?/[]{}|";
    String result = "";
    for (int i = 0; i < passlength; i++) {
      int randomIndex = random.nextInt(rawData.length);
      result += rawData[randomIndex];
    }
    setState(() {
      genPass = result;
    });
  }

  void showPop() {
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) => AlertDialog(
            backgroundColor: HexColor("#1f1f1f"),
            title: const Text("Generate Guide",
                style: TextStyle(color: Colors.white)),
            content: const Text(
                "By default it will generate password"
                " with uppercase and lowercase characters as well as"
                " with numbers, symbols and special characters of"
                " your given length. You can customize your password"
                " by tweaking the given check boxes.",
                style: TextStyle(color: Colors.white))));
  }

  Widget buildBottomSheetContent(BuildContext context) {
    return SizedBox(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 10, top: 10),
                  child: IconButton(
                    icon: const Icon(Icons.close_rounded),
                    color: Colors.white,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
            Card(
                elevation: 0,
                color: HexColor("#1f1f1f"),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: BorderSide.none),
                child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          const Center(
                              child: Text("Generated Password",
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white))),
                          const SizedBox(height: 16.0),
                          Center(
                              child: SizedBox(
                                  width: 260,
                                  child: Text(
                                    genPass,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        fontSize: 16.0, color: Colors.white),
                                  ))),
                          const SizedBox(height: 40),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(
                                  width: context.screenWidth / 2,
                                  height: 40,
                                  child: ElevatedButton(
                                      onPressed: () {
                                        copyMessageContent();
                                      },
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: HexColor("#e50914"),
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20.0)))),
                                      child: const Text("Copy",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16))),
                                ),
                              ])
                        ]))),
          ],
        ),
      ),
    );
  }
}

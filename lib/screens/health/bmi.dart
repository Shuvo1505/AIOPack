import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../components/gridlauncher.dart';
import '../../components/navbar.dart';

void main() {
  runApp(const BMIScreen());
}

class BMIScreen extends StatelessWidget {
  const BMIScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AIOPack',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(title: 'BMI Calculator'),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  late double result = 0.0;
  late String status = "";
  late String resultS = "";
  late String footer = "";

  static const String resultKey = "result_key_bmi";
  static const String statusKey = "status_key_bmi";
  static const String footerKey = "footer_key_bmi";

  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();

  notifyError(String message) {
    Fluttertoast.showToast(
        msg: message,
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_SHORT,
        fontSize: 16.0,
        backgroundColor: HexColor("#AF002A"),
        textColor: Colors.white);
  }

  var drawerKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: drawerKey,
        drawer: const NavPage(),
        appBar: AppBar(
          leading: IconButton(
              icon: const Icon(Icons.align_horizontal_left_rounded,
                  color: Colors.white),
              onPressed: () {
                FocusScope.of(context).requestFocus(FocusNode());
                drawerKey.currentState?.openDrawer();
              }),
          backgroundColor: HexColor("#050A0C"),
          centerTitle: true,
          title: Text(widget.title,
              style: const TextStyle(fontWeight: FontWeight.w300)),
          toolbarHeight: 90,
          actions: [
            IconButton(
              onPressed: () {
                showPop();
              },
              icon: const Icon(Icons.info_outline_rounded),
              color: Colors.white,
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const ExtrasPage(title: "Essential Tools")));
              },
              icon: const Icon(Icons.dashboard_customize_outlined),
              color: Colors.white,
            )
          ],
          titleTextStyle: const TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        body: Container(
            width: double.infinity,
            height: double.infinity,
            color: HexColor("#050A0C"),
            child: SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              margin: const EdgeInsets.all(12.0),
                              child: const Text("Choose Gender",
                                  style: TextStyle(
                                      fontSize: 24,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold))),
                          const SizedBox(height: 10),
                          Row(children: [
                            radioButton(
                                const Icon(Icons.male,
                                    size: 30, color: Colors.white),
                                Colors.white,
                                0,
                                "Male"),
                            radioButton(
                                const Icon(Icons.female,
                                    size: 30, color: Colors.white),
                                Colors.white,
                                1,
                                "Female")
                          ]),
                          const SizedBox(height: 30),
                          Container(
                            margin: const EdgeInsets.all(12.0),
                            child: const Text("Your Height (cm)",
                                style: TextStyle(
                                    fontSize: 24,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                          ),
                          TextField(
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              controller: heightController,
                              maxLength: 6,
                              textInputAction: TextInputAction.done,
                              onEditingComplete: () {
                                FocusScope.of(context).unfocus();
                              },
                              maxLines: 1,
                              cursorColor: Colors.white,
                              autofocus: false,
                              style: const TextStyle(
                                  fontSize: 16.4, color: Colors.white),
                              decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: HexColor("#e50914"),
                                          width: 2.0),
                                      borderRadius:
                                          BorderRadius.circular(20.0)),
                                  hintText: "Tap to type",
                                  hintStyle:
                                      const TextStyle(color: Colors.grey),
                                  filled: true,
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: HexColor("#e50914"),
                                          width: 5.0),
                                      borderRadius:
                                          BorderRadius.circular(20.0)),
                                  fillColor: HexColor("#1f1f1f"))),
                          const SizedBox(height: 4),
                          Container(
                              margin: const EdgeInsets.all(12.0),
                              child: const Text("Your Weight (kg)",
                                  style: TextStyle(
                                      fontSize: 24,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold))),
                          TextField(
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              controller: weightController,
                              maxLength: 6,
                              maxLines: 1,
                              cursorColor: Colors.white,
                              textInputAction: TextInputAction.done,
                              onEditingComplete: () {
                                FocusScope.of(context).unfocus();
                              },
                              autofocus: false,
                              style: const TextStyle(
                                  fontSize: 16.4, color: Colors.white),
                              decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: HexColor("#e50914"),
                                          width: 2.0),
                                      borderRadius:
                                          BorderRadius.circular(20.0)),
                                  hintText: "Tap to type",
                                  hintStyle:
                                      const TextStyle(color: Colors.grey),
                                  filled: true,
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: HexColor("#e50914"),
                                          width: 5.0),
                                      borderRadius:
                                          BorderRadius.circular(20.0)),
                                  fillColor: HexColor("#1f1f1f"))),
                          const SizedBox(height: 4),
                          Center(
                            child: SizedBox(
                              width: 260,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: HexColor("#e50914"),
                                      shape: ContinuousRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0))),
                                  onPressed: () {
                                    if (heightController.value.text == "" ||
                                        weightController.value.text == "") {
                                      notifyError("Missing a required field");
                                    } else {
                                      try {
                                        double h = double.parse(
                                            heightController.value.text);
                                        double w = double.parse(
                                            weightController.value.text);
                                        calculatedBMI(h, w);
                                        FocusScope.of(context).unfocus();
                                        storeGeneratedData();
                                      } on Exception catch (error) {
                                        notifyError(error.toString());
                                      }
                                    }
                                  },
                                  child: const Text("Calculate",
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.white))),
                            ),
                          ),
                          Center(
                              child: Column(children: [
                            const SizedBox(height: 40),
                            Text(status,
                                style: TextStyle(
                                    color: HexColor("#FFA500"),
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold)),
                            const SizedBox(height: 4),
                            Visibility(
                              visible: resultS.isEmpty ? true : false,
                              child: const Text("No data available",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 20,
                                  )),
                            ),
                            Text(resultS,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 40,
                                )),
                            const SizedBox(height: 4),
                            Text(footer,
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                )),
                            const SizedBox(height: 10),
                            Visibility(
                              visible: resultS.isEmpty ? false : true,
                              child: IconButton(
                                  onPressed: () {
                                    heightController.clear();
                                    weightController.clear();
                                    setState(() {
                                      resultS = "";
                                      status = "";
                                      footer = "";
                                    });
                                    storeGeneratedData();
                                  },
                                  icon: const Icon(Icons.delete,
                                      color: Colors.white, size: 30)),
                            )
                          ]))
                        ])))));
  }

  void changeIndex(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  void calculatedBMI(double height, double weight) {
    double finResult = weight / ((height / 100) * (height / 100));
    String temp = finResult.toStringAsFixed(2);
    setState(() {
      if (finResult < 16) {
        result = finResult;
        resultS = "$temp Kg/m²";
        status = "Severe Thinness";
        footer = "Your Calculated BMI";
      } else if (finResult >= 16 && finResult <= 17) {
        result = finResult;
        resultS = "$temp Kg/m²";
        status = "Moderate Thinness";
        footer = "Your Calculated BMI";
      } else if (finResult >= 17 && finResult <= 18.5) {
        result = finResult;
        resultS = "$temp Kg/m²";
        status = "Mild Thinness";
        footer = "Your Calculated BMI";
      } else if (finResult >= 18.5 && finResult <= 24.9) {
        result = finResult;
        resultS = "$temp Kg/m²";
        status = "Normal";
        footer = "Your Calculated BMI";
      } else if (finResult >= 25.0 && finResult <= 29.9) {
        result = finResult;
        resultS = "$temp Kg/m²";
        status = "Overweight";
        footer = "Your Calculated BMI";
      } else if (finResult >= 30.0 && finResult <= 34.9) {
        result = finResult;
        resultS = "$temp Kg/m²";
        status = "Obesity Class I";
        footer = "Your Calculated BMI";
      } else if (finResult >= 35.0 && finResult <= 39.9) {
        result = finResult;
        resultS = "$temp Kg/m²";
        status = "Obesity Class II";
        footer = "Your Calculated BMI";
      } else if (finResult >= 40) {
        result = finResult;
        resultS = "$temp Kg/m²";
        status = "Morbid Obesity";
        footer = "Your Calculated BMI";
      }
    });
  }

  void showPop() {
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) => AlertDialog(
            backgroundColor: HexColor("#1f1f1f"),
            title: const Text("What is BMI ?",
                style: TextStyle(color: Colors.white)),
            content: const Text(
                "BMI stands for Body Mass Index. "
                "It's a simple way to figure out if a person has a healthy "
                "weight for their height. BMI helps give an idea if someone is "
                "underweight, normal weight, overweight, or obese. "
                "However, it doesn't consider factors like muscle mass, "
                "so it's just a basic tool to get a general sense of whether "
                "someone's weight might be too high or too low for their "
                "height.",
                style: TextStyle(color: Colors.white))));
  }

  Widget radioButton(Icon value, Color color, int index, String data) {
    return Expanded(
        child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 12.0),
            child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                    backgroundColor: currentIndex == index
                        ? HexColor("#e50914")
                        : HexColor("#1f1f1f"),
                    shape: const ContinuousRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.0),
                            bottomRight: Radius.circular(20.0)))),
                onPressed: () {
                  changeIndex(index);
                },
                icon: value,
                label: Text(data,
                    style:
                        const TextStyle(fontSize: 18, color: Colors.white)))));
  }

  Future<void> loadGeneratedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      resultS = prefs.getString(resultKey) ?? "";
      status = prefs.getString(statusKey) ?? "";
      footer = prefs.getString(footerKey) ?? "";
    });
  }

  Future<void> storeGeneratedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString(resultKey, resultS);
    prefs.setString(statusKey, status);
    prefs.setString(footerKey, footer);
  }

  @override
  void initState() {
    loadGeneratedData();
    super.initState();
  }

  @override
  void dispose() {
    heightController.dispose();
    weightController.dispose();
    super.dispose();
  }
}

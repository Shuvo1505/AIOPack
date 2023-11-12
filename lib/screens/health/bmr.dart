import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const BMRScreen());
}

class BMRScreen extends StatelessWidget {
  const BMRScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AIOPack',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const BMRPage(title: 'BMR Calculator'),
    );
  }
}

class BMRPage extends StatefulWidget {
  const BMRPage({super.key, required this.title});

  final String title;

  @override
  State<BMRPage> createState() => _BMRPageState();
}

class _BMRPageState extends State<BMRPage> {
  int currentIndex = 0;
  late double result = 0.0;
  late String status = "";
  late String resultS = "";
  late String sed = "";
  late String liactive = "";
  late String modactive = "";
  late String active = "";
  late String vactive = "";
  late String datasheet = "";

  static const String statusKey = "status_key_bmr";
  static const String resultKey = "result_key_bmr";
  static const String sedKey = "sed_key_bmr";
  static const String liactiveKey = "light_active_key_bmr";
  static const String modactiveKey = "moderate_active_key_bmr";
  static const String activeKey = "active_key_bmr";
  static const String vactiveKey = "very_active_key_bmr";
  static const String datasheetKey = "datasheet_key_bmr";

  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  notifyError(String message) {
    Fluttertoast.showToast(
        msg: message,
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_SHORT,
        fontSize: 16.0,
        backgroundColor: HexColor("#AF002A"),
        textColor: Colors.white);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon:
                const Icon(Icons.arrow_back_ios_new_sharp, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
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
                          Container(
                              margin: const EdgeInsets.all(12.0),
                              child: const Text("Your Age (years)",
                                  style: TextStyle(
                                      fontSize: 24,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold))),
                          TextField(
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              controller: ageController,
                              maxLength: 3,
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
                                        weightController.value.text == "" ||
                                        ageController.value.text == "") {
                                      notifyError("Missing a required field");
                                    } else {
                                      try {
                                        double h = double.parse(
                                            heightController.value.text);
                                        double w = double.parse(
                                            weightController.value.text);
                                        double a = double.parse(
                                            ageController.value.text);
                                        FocusScope.of(context).unfocus();
                                        calculatedBMR(h, w, a);
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
                            Visibility(
                              visible: resultS.isEmpty ? true : false,
                              child: const Text("No data available",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 20,
                                  )),
                            ),
                            Text(status,
                                style: TextStyle(
                                    color: HexColor("#FFA500"),
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold)),
                            const SizedBox(height: 4),
                            Text(resultS,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 40,
                                )),
                            const SizedBox(height: 30),
                            Text(datasheet,
                                style: TextStyle(
                                    color: HexColor("#FFA500"),
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold)),
                            Container(
                                margin: const EdgeInsets.all(12.0),
                                child: Column(children: [
                                  Text(sed,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 10),
                                  Text(liactive,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 10),
                                  Text(modactive,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 10),
                                  Text(active,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 10),
                                  Text(vactive,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 10),
                                  Visibility(
                                    visible: resultS.isEmpty ? false : true,
                                    child: IconButton(
                                        onPressed: () {
                                          heightController.clear();
                                          weightController.clear();
                                          ageController.clear();
                                          setState(() {
                                            resultS = "";
                                            status = "";
                                            liactive = "";
                                            sed = "";
                                            modactive = "";
                                            active = "";
                                            vactive = "";
                                            datasheet = "";
                                          });
                                          storeGeneratedData();
                                        },
                                        icon: const Icon(Icons.delete,
                                            color: Colors.white, size: 30)),
                                  )
                                ])),
                          ]))
                        ])))));
  }

  void changeIndex(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  void calculatedBMR(double height, double weight, double age) {
    if (currentIndex == 0) {
      double finResult = (10 * weight) + (6.25 * height) - (5 * age) + 5;

      double sedact = (finResult * 1.2);
      double lightact = (finResult * 1.375);
      double modact = (finResult * 1.55);
      double act = (finResult * 1.725);
      double vact = (finResult * 1.9);

      String temp = finResult.toStringAsFixed(2);
      String sedacts = sedact.toStringAsFixed(3);
      String lightacts = lightact.toStringAsFixed(3);
      String modacts = modact.toStringAsFixed(3);
      String acts = act.toStringAsFixed(3);
      String vacts = vact.toStringAsFixed(3);

      setState(() {
        result = finResult;
        resultS = "$temp cal/day";
        status = "Calculated BMR";
        sed = "Sedentary (little or no exercise): $sedacts "
            "Calorie/s";
        liactive = "Lightly active (exercise 1–3 days/week): $lightacts "
            "Calorie/s";
        modactive = "Moderately active (exercise 3–5 days/week): $modacts "
            "Calorie/s";
        active = "Active (exercise 6–7 days/week): $acts Calorie/s";
        vactive = "Very active (hard exercise 6–7 days/week): $vacts "
            "Calorie/s";
        datasheet = "Calculated Data Sheet";
      });
    }
    if (currentIndex == 1) {
      double finResult = (10 * weight) + (6.25 * height) - (5 * age) - 161;

      double sedact = (finResult * 1.2);
      double lightact = (finResult * 1.375);
      double modact = (finResult * 1.55);
      double act = (finResult * 1.725);
      double vact = (finResult * 1.9);

      String temp = finResult.toStringAsFixed(2);
      String sedacts = sedact.toStringAsFixed(3);
      String lightacts = lightact.toStringAsFixed(3);
      String modacts = modact.toStringAsFixed(3);
      String acts = act.toStringAsFixed(3);
      String vacts = vact.toStringAsFixed(3);

      setState(() {
        result = finResult;
        resultS = "$temp cal/day";
        status = "Calculated BMR";
        sed = "Sedentary (little or no exercise): $sedacts "
            "Calorie/s";
        liactive = "Lightly active (exercise 1–3 days/week): $lightacts "
            "Calorie/s";
        modactive = "Moderately active (exercise 3–5 days/week): $modacts "
            "Calorie/s";
        active = "Active (exercise 6–7 days/week): $acts Calorie/s";
        vactive = "Very active (hard exercise 6–7 days/week): $vacts "
            "Calorie/s";
        datasheet = "Calculated Data Sheet";
      });
    }
  }

  void showPop() {
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) => AlertDialog(
            backgroundColor: HexColor("#1f1f1f"),
            title: const Text("What is BMR ?",
                style: TextStyle(color: Colors.white)),
            content: const Text(
                "BMR stands for Basal Metabolic Rate. "
                "Imagine your body is like a car that's always running, "
                "even when you're not moving. BMR is like the fuel your body "
                "needs to keep running to do basic things like breathing, "
                "circulating blood, and keeping your organs working. "
                "It's the number of calories your body uses just to stay alive "
                "and function while you're at rest – kind of like the energy "
                "your body needs to keep the lights on.",
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
      sed = prefs.getString(sedKey) ?? "";
      liactive = prefs.getString(liactiveKey) ?? "";
      modactive = prefs.getString(modactiveKey) ?? "";
      active = prefs.getString(activeKey) ?? "";
      vactive = prefs.getString(vactiveKey) ?? "";
      datasheet = prefs.getString(datasheetKey) ?? "";
    });
  }

  Future<void> storeGeneratedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString(resultKey, resultS);
    prefs.setString(statusKey, status);
    prefs.setString(sedKey, sed);
    prefs.setString(liactiveKey, liactive);
    prefs.setString(modactiveKey, modactive);
    prefs.setString(activeKey, active);
    prefs.setString(vactiveKey, vactive);
    prefs.setString(datasheetKey, datasheet);
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
    ageController.dispose();
    super.dispose();
  }
}

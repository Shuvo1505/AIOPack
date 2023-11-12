import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const InterestScreen());
}

class InterestScreen extends StatelessWidget {
  const InterestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AIOPack',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const InterestPage(),
    );
  }
}

class InterestPage extends StatefulWidget {
  const InterestPage({super.key});

  @override
  State<InterestPage> createState() => _InterestPageState();
}

class _InterestPageState extends State<InterestPage> {
  TextEditingController loanController = TextEditingController();
  TextEditingController yearController = TextEditingController();
  TextEditingController rateController = TextEditingController();
  TextEditingController compoundTimeController = TextEditingController();

  late String selectedValue = "Simple Interest";

  List<String> dropdownItems = ["Simple Interest", "Compound Interest"];

  late String interestValue = "";
  late String totalPayInt = "";
  late String statusHead = "";
  late bool compoundFreq = false;

  static const interestKey = "int_key_inte";
  static const totalKey = "total_key_inte";
  static const statusKey = "status_key_inte";

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
              icon: const Icon(Icons.arrow_back_ios_new_sharp,
                  color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              }),
          backgroundColor: HexColor("#050A0C"),
          centerTitle: true,
          title: const Text("Interest Rate Calculator",
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
                          Row(
                            children: [
                              Container(
                                  margin: const EdgeInsets.all(12.0),
                                  child: const Text("Enter Loan Amount",
                                      style: TextStyle(
                                          fontSize: 24,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold))),
                            ],
                          ),
                          TextField(
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              controller: loanController,
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
                          const SizedBox(height: 16),
                          Center(
                              child: SizedBox(
                            height: 60,
                            width: 60,
                            child: Image.asset("assets/images/down-arrow.png"),
                          )),
                          const SizedBox(height: 16),
                          Center(
                              child: Card(
                                  elevation: 4,
                                  color: HexColor("#1f1f1f"),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      side: BorderSide.none),
                                  child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16),
                                      child: Theme(
                                        data: Theme.of(context).copyWith(
                                            canvasColor: HexColor("#1f1f1f")),
                                        child: DropdownButton<String>(
                                          value: selectedValue,
                                          onChanged: (newValue) {
                                            setState(() {
                                              selectedValue = newValue!;
                                              if (selectedValue ==
                                                  dropdownItems[1]) {
                                                compoundFreq = true;
                                              } else {
                                                compoundFreq = false;
                                              }
                                            });
                                          },
                                          items: dropdownItems
                                              .map<DropdownMenuItem<String>>(
                                                  (String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              alignment: Alignment.center,
                                              child: Text(value,
                                                  style: const TextStyle(
                                                      color: Colors.white)),
                                            );
                                          }).toList(),
                                          borderRadius:
                                              BorderRadius.circular(18.0),
                                          underline: Container(),
                                          icon: const Icon(
                                              Icons
                                                  .arrow_drop_down_circle_outlined,
                                              color: Colors.white),
                                        ),
                                      )))),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Visibility(
                                visible: compoundFreq,
                                child: Container(
                                    margin: const EdgeInsets.all(12.0),
                                    child: const Text("Compund Time (Anually)",
                                        style: TextStyle(
                                            fontSize: 24,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold))),
                              ),
                            ],
                          ),
                          Visibility(
                            visible: compoundFreq,
                            child: TextField(
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                        decimal: false),
                                textAlign: TextAlign.center,
                                controller: compoundTimeController,
                                textInputAction: TextInputAction.done,
                                onEditingComplete: () {
                                  FocusScope.of(context).unfocus();
                                },
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
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Container(
                                  margin: const EdgeInsets.all(12.0),
                                  child: const Text("Enter Tenure (Years)",
                                      style: TextStyle(
                                          fontSize: 24,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold))),
                            ],
                          ),
                          TextField(
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              controller: yearController,
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
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Container(
                                  margin: const EdgeInsets.all(12.0),
                                  child: const Text("Enter Interest Rate ( % )",
                                      style: TextStyle(
                                          fontSize: 24,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold))),
                            ],
                          ),
                          TextField(
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              controller: rateController,
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
                          const SizedBox(height: 30),
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
                                        if (selectedValue == dropdownItems[0]) {
                                          if (loanController.value.text == "" ||
                                              yearController.value.text == "" ||
                                              rateController.value.text == "") {
                                            notifyError(
                                                "Missing a required field");
                                            FocusScope.of(context).unfocus();
                                          } else {
                                            try {
                                              double p = double.parse(
                                                  loanController.value.text);
                                              double t = double.parse(
                                                  yearController.value.text);
                                              double r = double.parse(
                                                  rateController.value.text);
                                              FocusScope.of(context).unfocus();
                                              calculatedInterest(p, t, r, 0);
                                              storeGeneratedData();
                                            } on Exception catch (error) {
                                              notifyError(error.toString());
                                            }
                                          }
                                        }
                                        if (selectedValue == dropdownItems[1]) {
                                          if (loanController.value.text == "" ||
                                              yearController.value.text == "" ||
                                              rateController.value.text == "" ||
                                              compoundTimeController
                                                      .value.text ==
                                                  "") {
                                            notifyError(
                                                "Missing a required field");
                                            FocusScope.of(context).unfocus();
                                          } else {
                                            try {
                                              double p = double.parse(
                                                  loanController.value.text);
                                              double t = double.parse(
                                                  yearController.value.text);
                                              double r = double.parse(
                                                  rateController.value.text);
                                              double cf = double.parse(
                                                  compoundTimeController
                                                      .value.text);
                                              FocusScope.of(context).unfocus();
                                              calculatedInterest(p, t, r, cf);
                                              storeGeneratedData();
                                            } on Exception catch (error) {
                                              notifyError(error.toString());
                                            }
                                          }
                                        }
                                      },
                                      child: const Text("Calculate",
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
                                          selectedValue = dropdownItems[0];
                                          loanController.clear();
                                          yearController.clear();
                                          rateController.clear();
                                          compoundTimeController.clear();
                                          statusHead = "";
                                          interestValue = "";
                                          totalPayInt = "";
                                          FocusScope.of(context).unfocus();
                                          compoundFreq = false;
                                          storeGeneratedData();
                                        });
                                      },
                                      child: const Text("Reset",
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white))),
                                )
                              ]),
                          const SizedBox(height: 16),
                          Center(
                              child: Column(children: [
                            const SizedBox(height: 10),
                            Visibility(
                              visible: interestValue.isEmpty ? true : false,
                              child: const Text("No data available",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 20,
                                  )),
                            ),
                            const SizedBox(height: 20),
                            Visibility(
                              visible: interestValue.isEmpty ? false : true,
                              child: Text(statusHead,
                                  style: TextStyle(
                                      color: HexColor("#FFA500"),
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold)),
                            ),
                            const SizedBox(height: 10),
                            Visibility(
                              visible: interestValue.isEmpty ? false : true,
                              child: Text(interestValue,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center),
                            ),
                            const SizedBox(height: 6),
                            Visibility(
                                visible: interestValue.isEmpty ? false : true,
                                child: const Text("Your Interest Amount",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 18,
                                    ))),
                            const SizedBox(height: 6),
                            Visibility(
                                visible: interestValue.isEmpty ? false : true,
                                child: const Divider(
                                    thickness: 2, color: Colors.grey)),
                            const SizedBox(height: 6),
                            Visibility(
                              visible: interestValue.isEmpty ? false : true,
                              child: Text(totalPayInt,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center),
                            ),
                            const SizedBox(height: 6),
                            Visibility(
                                visible: interestValue.isEmpty ? false : true,
                                child: const Text(
                                    "Total Payment "
                                    "(Principal + Interest)",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 18,
                                    )))
                          ]))
                        ])))));
  }

  void calculatedInterest(
      double principal, double time, double rate, double compoundFrequency) {
    var fail = 0;
    if (selectedValue == "Simple Interest") {
      if (principal > 0 && rate > 0 && time > 0) {
        double result = (principal * time * rate) / 100;
        double totalInterest = principal + result;
        String mod = result.toStringAsFixed(0);
        String mod2 = totalInterest.toStringAsFixed(0);
        setState(() {
          statusHead = "Simple Interest";
          interestValue = "₹ $mod /-";
          totalPayInt = "₹ $mod2 /-";
        });
      } else {
        setState(() {
          statusHead = "Invalid Data";
          interestValue = "₹ $fail /-";
          totalPayInt = "₹ $fail /-";
        });
      }
    }
    if (selectedValue == "Compound Interest") {
      if (principal > 0 && time > 0 && rate > 0 && compoundFrequency > 0) {
        double convRate = (rate / 100);
        double calc = (convRate / compoundFrequency);
        double add = 1 + calc;
        double nt = (compoundFrequency * time);
        num tothe = pow(add, nt);
        num amount = (principal * tothe);
        num compound = (amount - principal);

        String mod = compound.toStringAsFixed(0);
        String mod2 = amount.toStringAsFixed(0);
        setState(() {
          statusHead = "Compound Interest";
          interestValue = "₹ $mod /-";
          totalPayInt = "₹ $mod2 /-";
        });
      } else {
        setState(() {
          statusHead = "Invalid Data";
          interestValue = "₹ $fail /-";
          totalPayInt = "₹ $fail /-";
        });
      }
    }
  }

  Future<void> loadGeneratedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      interestValue = prefs.getString(interestKey) ?? "";
      totalPayInt = prefs.getString(totalKey) ?? "";
      statusHead = prefs.getString(statusKey) ?? "";
    });
  }

  Future<void> storeGeneratedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(interestKey, interestValue);
    prefs.setString(totalKey, totalPayInt);
    prefs.setString(statusKey, statusHead);
  }

  @override
  void initState() {
    loadGeneratedData();
    super.initState();
  }

  @override
  void dispose() {
    loanController.dispose();
    yearController.dispose();
    rateController.dispose();
    compoundTimeController.dispose();
    super.dispose();
  }
}

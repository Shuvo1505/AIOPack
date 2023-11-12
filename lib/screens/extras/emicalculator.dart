import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const EMIScreen());
}

class EMIScreen extends StatelessWidget {
  const EMIScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AIOPack',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const EMIPage(),
    );
  }
}

class EMIPage extends StatefulWidget {
  const EMIPage({super.key});

  @override
  State<EMIPage> createState() => _EMIPageState();
}

class _EMIPageState extends State<EMIPage> {
  TextEditingController loanController = TextEditingController();
  TextEditingController yearController = TextEditingController();
  TextEditingController rateController = TextEditingController();

  late String selectedValue = "Home Loan";

  List<String> dropdownItems = ["Home Loan", "Personal Loan", "Car Loan"];

  late String monthValue = "";
  late String totalPay = "";
  late String totalintPay = "";
  late String statusHead = "";

  static const String monthKey = "month_key_em";
  static const String statusKey = "stat_key_em";
  static const String tpKey = "total_pay_em";
  static const String tiKey = "total_in_em";

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
          title: const Text("EMI Calculator",
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
                                          horizontal: 12),
                                      child: Theme(
                                        data: Theme.of(context).copyWith(
                                            canvasColor: HexColor("#1f1f1f")),
                                        child: DropdownButton<String>(
                                          value: selectedValue,
                                          onChanged: (newValue) {
                                            setState(() {
                                              selectedValue = newValue!;
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
                                            double i = double.parse(
                                                rateController.value.text);
                                            FocusScope.of(context).unfocus();
                                            calculatedEMI(p, i, t);
                                            storeGeneratedData();
                                          } on Exception catch (error) {
                                            notifyError(error.toString());
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
                                          monthValue = "";
                                          totalPay = "";
                                          totalintPay = "";
                                          statusHead = "";
                                          FocusScope.of(context).unfocus();
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
                            const SizedBox(height: 20),
                            Visibility(
                              visible: monthValue.isEmpty ? false : true,
                              child: Text(statusHead,
                                  style: TextStyle(
                                      color: HexColor("#FFA500"),
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold)),
                            ),
                            Visibility(
                              visible: monthValue.isEmpty ? true : false,
                              child: const Text("No data available",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 20,
                                  )),
                            ),
                            const SizedBox(height: 10),
                            Visibility(
                              visible: monthValue.isEmpty ? false : true,
                              child: Text(monthValue,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center),
                            ),
                            const SizedBox(height: 6),
                            Visibility(
                                visible: monthValue.isEmpty ? false : true,
                                child: const Text("Your EMI Amount",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 18,
                                    ))),
                            const SizedBox(height: 6),
                            Visibility(
                                visible: monthValue.isEmpty ? false : true,
                                child: const Divider(
                                    thickness: 2, color: Colors.grey)),
                            const SizedBox(height: 6),
                            Visibility(
                                visible: totalPay.isEmpty ? false : true,
                                child: Text(totalPay,
                                    style: const TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center)),
                            const SizedBox(height: 6),
                            Visibility(
                                visible: totalPay.isEmpty ? false : true,
                                child:
                                    const Text("Total Payment (EMI + Interest)",
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 18,
                                        ))),
                            const SizedBox(height: 6),
                            Visibility(
                                visible: totalPay.isEmpty ? false : true,
                                child: const Divider(
                                    thickness: 2, color: Colors.grey)),
                            const SizedBox(height: 6),
                            Visibility(
                                visible: totalintPay.isEmpty ? false : true,
                                child: Text(totalintPay,
                                    style: const TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center)),
                            const SizedBox(height: 6),
                            Visibility(
                                visible: totalintPay.isEmpty ? false : true,
                                child: const Text("Total Interest Payable",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 18,
                                    ))),
                          ]))
                        ])))));
  }

  void calculatedEMI(double principal, double interestRate, double tenure) {
    double fail = 0;

    if (principal > 0 && interestRate > 0 && tenure > 0) {
      double monthlyInterestRate = interestRate / 12 / 100;
      double totalPayments = tenure * 12;
      double numerator = principal *
          monthlyInterestRate *
          pow(1 + monthlyInterestRate, totalPayments);

      double denominator = pow(1 + monthlyInterestRate, totalPayments) - 1;
      double emi = numerator / denominator;
      double totalPayment = emi * totalPayments;
      double totalInterest = totalPayment - principal;

      String mod = emi.toStringAsFixed(0);
      String mod2 = totalPayment.toStringAsFixed(0);
      String mod3 = totalInterest.toStringAsFixed(0);

      if (selectedValue == "Home Loan") {
        setState(() {
          monthValue = "₹ $mod /-";
          totalPay = "₹ $mod2 /-";
          totalintPay = "₹ $mod3 /-";
          statusHead = "Home Loan";
        });
      }
      if (selectedValue == "Personal Loan") {
        setState(() {
          monthValue = "₹ $mod /-";
          totalPay = "₹ $mod2 /-";
          totalintPay = "₹ $mod3 /-";
          statusHead = "Personal Loan";
        });
      }
      if (selectedValue == "Car Loan") {
        setState(() {
          monthValue = "₹ $mod /-";
          totalPay = "₹ $mod2 /-";
          totalintPay = "₹ $mod3 /-";
          statusHead = "Car Loan";
        });
      }
    } else {
      setState(() {
        monthValue = "₹ $fail /-";
        totalPay = "₹ $fail /-";
        totalintPay = "₹ $fail /-";
        statusHead = "Invalid Data";
      });
    }
  }

  Future<void> loadGeneratedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      monthValue = prefs.getString(monthKey) ?? "";
      statusHead = prefs.getString(statusKey) ?? "";
      totalPay = prefs.getString(tpKey) ?? "";
      totalintPay = prefs.getString(tiKey) ?? "";
    });
  }

  Future<void> storeGeneratedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(monthKey, monthValue);
    prefs.setString(statusKey, statusHead);
    prefs.setString(tpKey, totalPay);
    prefs.setString(tiKey, totalintPay);
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
    super.dispose();
  }
}

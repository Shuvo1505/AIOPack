import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const WeightScreen());
}

class WeightScreen extends StatelessWidget {
  const WeightScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AIOPack',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const WeightPage(title: 'Weight Converter'),
    );
  }
}

class WeightPage extends StatefulWidget {
  const WeightPage({super.key, required this.title});

  final String title;

  @override
  State<WeightPage> createState() => _WeightPageState();
}

class _WeightPageState extends State<WeightPage> {
  TextEditingController unitController = TextEditingController();

  late String selectedValue = "Gram (g)";

  List<String> dropdownItems = [
    "Gram (g)",
    "Quintal (q)",
    "Carat (ct)",
    "Ton (t)",
    "Milligram (mg)",
    "Kilogram (kg)",
    "Microgram (μg)",
    "Pound (lb)"
  ];

  late double gram = 0.0;
  late double quintal = 0.0;
  late double carat = 0.0;
  late double ton = 0.0;
  late double milligram = 0.0;
  late double kilogram = 0.0;
  late double microgram = 0.0;
  late double pound = 0.0;

  late String grams = "";
  late String quintals = "";
  late String carats = "";
  late String tons = "";
  late String milligrams = "";
  late String kilograms = "";
  late String micrograms = "";
  late String pounds = "";

  late bool isState = false;

  static const String gramKey = "gram_key_wei";
  static const String quinKey = "quin_key_wei";
  static const String caraKey = "cara_key_wei";
  static const String tonKey = "ton_key_wei";
  static const String milliKey = "milli_key_wei";
  static const String kiloKey = "kilo_key_wei";
  static const String microKey = "micro_key_wei";
  static const String poundKey = "pound_key_wei";
  static const String stateKey = "state_key_wei";

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
          title: Text(widget.title,
              style: const TextStyle(fontWeight: FontWeight.w300)),
          toolbarHeight: 90,
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
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Container(
                                  margin: const EdgeInsets.all(12.0),
                                  child: const Text("Enter Value Here",
                                      style: TextStyle(
                                          fontSize: 24,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold))),
                            ],
                          ),
                          TextField(
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              controller: unitController,
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
                          Center(
                            child: SizedBox(
                              height: 60,
                              width: 60,
                              child:
                                  Image.asset("assets/images/down-arrow.png"),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Center(
                            child: Card(
                              elevation: 4,
                              color: HexColor("#1f1f1f"),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  side: BorderSide.none),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                child: Theme(
                                  data: Theme.of(context).copyWith(
                                    canvasColor: HexColor("#1f1f1f"),
                                  ),
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
                                    borderRadius: BorderRadius.circular(18.0),
                                    underline: Container(),
                                    icon: const Icon(
                                        Icons.arrow_drop_down_circle_outlined,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
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
                                        if (unitController.value.text == "") {
                                          notifyError(
                                              "Missing a required field");
                                        } else {
                                          try {
                                            double data = double.parse(
                                                unitController.value.text);
                                            FocusScope.of(context).unfocus();
                                            calculatedWeights(data);
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
                                          grams = "";
                                          micrograms = "";
                                          quintals = "";
                                          carats = "";
                                          tons = "";
                                          milligrams = "";
                                          kilograms = "";
                                          pounds = "";
                                          isState = false;
                                          FocusScope.of(context).unfocus();
                                          selectedValue = dropdownItems[0];
                                          unitController.clear();
                                          storeGeneratedData();
                                        });
                                      },
                                      child: const Text("Reset",
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white))),
                                ),
                              ]),
                          const SizedBox(height: 16),
                          Center(
                              child: Column(children: [
                            const SizedBox(height: 26),
                            Visibility(
                              visible: isState,
                              child: Text("Calculated Result",
                                  style: TextStyle(
                                      color: HexColor("#FFA500"),
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                            ),
                            const SizedBox(height: 20),
                            Text(grams,
                                style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center),
                            Visibility(
                                visible: isState,
                                child: const Divider(
                                  color: Colors.grey,
                                  thickness: 2,
                                )),
                            Text(micrograms,
                                style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center),
                            const SizedBox(height: 10),
                            Visibility(
                                visible: isState,
                                child: const Divider(
                                  color: Colors.grey,
                                  thickness: 2,
                                )),
                            Text(quintals,
                                style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center),
                            Visibility(
                              visible: isState == false ? true : false,
                              child: const Text("No data available",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 20,
                                  )),
                            ),
                            const SizedBox(height: 10),
                            Visibility(
                                visible: isState,
                                child: const Divider(
                                  color: Colors.grey,
                                  thickness: 2,
                                )),
                            Text(carats,
                                style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center),
                            const SizedBox(height: 10),
                            Visibility(
                                visible: isState,
                                child: const Divider(
                                  color: Colors.grey,
                                  thickness: 2,
                                )),
                            Text(tons,
                                style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center),
                            const SizedBox(height: 10),
                            Visibility(
                                visible: isState,
                                child: const Divider(
                                  color: Colors.grey,
                                  thickness: 2,
                                )),
                            Text(
                              milligrams,
                              style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 10),
                            Visibility(
                                visible: isState,
                                child: const Divider(
                                  color: Colors.grey,
                                  thickness: 2,
                                )),
                            Text(kilograms,
                                style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center),
                            const SizedBox(height: 10),
                            Visibility(
                                visible: isState,
                                child: const Divider(
                                  color: Colors.grey,
                                  thickness: 2,
                                )),
                            Text(pounds,
                                style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center),
                            const SizedBox(height: 10),
                            Visibility(
                                visible: isState,
                                child: const Divider(
                                  color: Colors.grey,
                                  thickness: 2,
                                ))
                          ]))
                        ])))));
  }

  void calculatedWeights(double value) {
    if (selectedValue == "Gram (g)") {
      microgram = (value * 1000000);
      quintal = (value / 100000);
      carat = (value * 5);
      ton = (value / 1000000);
      milligram = (value * 1000);
      kilogram = (value / 1000);
      pound = (value / 453.59237);

      String mod1 = microgram.toStringAsFixed(13);
      String mod2 = quintal.toStringAsFixed(13);
      String mod3 = carat.toStringAsFixed(13);
      String mod4 = ton.toStringAsFixed(13);
      String mod5 = milligram.toStringAsFixed(13);
      String mod6 = kilogram.toStringAsFixed(13);
      String mod7 = pound.toStringAsFixed(13);

      setState(() {
        isState = true;
        micrograms = "$mod1 Microgram (μg)";
        quintals = "$mod2 Quintal (q)";
        carats = "$mod3 Carat (ct)";
        tons = "$mod4 Ton (t)";
        milligrams = "$mod5 Milligram (mg)";
        kilograms = "$mod6 Kilogram (kg)";
        pounds = "$mod7 Pound (lb)";
        grams = "$value Gram (g)";
      });
    }
    if (selectedValue == "Quintal (q)") {
      microgram = (value * 100000000000);
      carat = (value * 500000);
      ton = (value / 10);
      milligram = (value * 100000000);
      kilogram = (value * 100);
      pound = (value * 220.462);
      gram = (value * 100000);

      String mod1 = microgram.toStringAsFixed(13);
      String mod2 = gram.toStringAsFixed(13);
      String mod3 = carat.toStringAsFixed(13);
      String mod4 = ton.toStringAsFixed(13);
      String mod5 = milligram.toStringAsFixed(13);
      String mod6 = kilogram.toStringAsFixed(13);
      String mod7 = pound.toStringAsFixed(13);

      setState(() {
        isState = true;
        micrograms = "$mod1 Microgram (μg)";
        quintals = "$value Quintal (q)";
        carats = "$mod3 Carat (ct)";
        tons = "$mod4 Ton (t)";
        milligrams = "$mod5 Milligram (mg)";
        kilograms = "$mod6 Kilogram (kg)";
        pounds = "$mod7 Pound (lb)";
        grams = "$mod2 Gram (g)";
      });
    }

    if (selectedValue == "Carat (ct)") {
      microgram = (value * 200000);
      carat = value;
      ton = (value / 2000000);
      milligram = (value * 200);
      kilogram = (value / 5000);
      pound = (value / 2267.96185);
      gram = (value / 5);
      quintal = (value * 0.00002);

      String mod1 = microgram.toStringAsFixed(13);
      String mod2 = gram.toStringAsFixed(13);
      String mod3 = quintal.toStringAsFixed(13);
      String mod4 = ton.toStringAsFixed(13);
      String mod5 = milligram.toStringAsFixed(13);
      String mod6 = kilogram.toStringAsFixed(13);
      String mod7 = pound.toStringAsFixed(13);

      setState(() {
        isState = true;
        micrograms = "$mod1 Microgram (μg)";
        quintals = "$mod3 Quintal (q)";
        carats = "$value Carat (ct)";
        tons = "$mod4 Ton (t)";
        milligrams = "$mod5 Milligram (mg)";
        kilograms = "$mod6 Kilogram (kg)";
        pounds = "$mod7 Pound (lb)";
        grams = "$mod2 Gram (g)";
      });
    }

    if (selectedValue == "Ton (t)") {
      microgram = (value * 1000000000000);
      carat = (value * 5000000);
      ton = value;
      milligram = (value * 1000000000);
      kilogram = (value * 1000);
      pound = (value * 2204.62);
      gram = (value * 1000000);
      quintal = (value * 10);

      String mod1 = microgram.toStringAsFixed(13);
      String mod2 = gram.toStringAsFixed(13);
      String mod3 = quintal.toStringAsFixed(13);
      String mod4 = carat.toStringAsFixed(13);
      String mod5 = milligram.toStringAsFixed(13);
      String mod6 = kilogram.toStringAsFixed(13);
      String mod7 = pound.toStringAsFixed(13);

      setState(() {
        isState = true;
        micrograms = "$mod1 Microgram (μg)";
        quintals = "$mod3 Quintal (q)";
        carats = "$mod4 Carat (ct)";
        tons = "$value Ton (t)";
        milligrams = "$mod5 Milligram (mg)";
        kilograms = "$mod6 Kilogram (kg)";
        pounds = "$mod7 Pound (lb)";
        grams = "$mod2 Gram (g)";
      });
    }

    if (selectedValue == "Milligram (mg)") {
      microgram = (value * 1000);
      carat = (value / 200);
      ton = (value / 1000000000);
      milligram = value;
      kilogram = (value / 1000000);
      pound = (value / 453592.37);
      gram = (value / 1000);
      quintal = (value / 100000000);

      String mod1 = microgram.toStringAsFixed(13);
      String mod2 = gram.toStringAsFixed(13);
      String mod3 = quintal.toStringAsFixed(13);
      String mod4 = carat.toStringAsFixed(13);
      String mod5 = ton.toStringAsFixed(13);
      String mod6 = kilogram.toStringAsFixed(13);
      String mod7 = pound.toStringAsFixed(13);

      setState(() {
        isState = true;
        micrograms = "$mod1 Microgram (μg)";
        quintals = "$mod3 Quintal (q)";
        carats = "$mod4 Carat (ct)";
        tons = "$mod5 Ton (t)";
        milligrams = "$value Milligram (mg)";
        kilograms = "$mod6 Kilogram (kg)";
        pounds = "$mod7 Pound (lb)";
        grams = "$mod2 Gram (g)";
      });
    }

    if (selectedValue == "Kilogram (kg)") {
      microgram = (value * 1000000000);
      carat = (value * 5000);
      ton = (value / 1000);
      milligram = (value * 1000000);
      kilogram = value;
      pound = (value * 2.20462262);
      gram = (value * 1000);
      quintal = (value / 100);

      String mod1 = microgram.toStringAsFixed(13);
      String mod2 = gram.toStringAsFixed(13);
      String mod3 = quintal.toStringAsFixed(13);
      String mod4 = carat.toStringAsFixed(13);
      String mod5 = ton.toStringAsFixed(13);
      String mod6 = milligram.toStringAsFixed(13);
      String mod7 = pound.toStringAsFixed(13);

      setState(() {
        isState = true;
        micrograms = "$mod1 Microgram (μg)";
        quintals = "$mod3 Quintal (q)";
        carats = "$mod4 Carat (ct)";
        tons = "$mod5 Ton (t)";
        milligrams = "$mod6 Milligram (mg)";
        kilograms = "$value Kilogram (kg)";
        pounds = "$mod7 Pound (lb)";
        grams = "$mod2 Gram (g)";
      });
    }

    if (selectedValue == "Microgram (μg)") {
      microgram = value;
      carat = (value / 200000);
      ton = (value / 1000000000000);
      milligram = (value / 1000);
      kilogram = (value / 1000000000);
      pound = (value / 453590000);
      gram = (value / 1000000);
      quintal = (value / 10000000000);

      String mod1 = kilogram.toStringAsFixed(13);
      String mod2 = gram.toStringAsFixed(13);
      String mod3 = quintal.toStringAsFixed(13);
      String mod4 = carat.toStringAsFixed(13);
      String mod5 = ton.toStringAsFixed(13);
      String mod6 = milligram.toStringAsFixed(13);
      String mod7 = pound.toStringAsFixed(13);

      setState(() {
        isState = true;
        micrograms = "$value Microgram (μg)";
        quintals = "$mod3 Quintal (q)";
        carats = "$mod4 Carat (ct)";
        tons = "$mod5 Ton (t)";
        milligrams = "$mod6 Milligram (mg)";
        kilograms = "$mod1 Kilogram (kg)";
        pounds = "$mod7 Pound (lb)";
        grams = "$mod2 Gram (g)";
      });
    }

    if (selectedValue == "Pound (lb)") {
      microgram = (value * 453590000);
      carat = (value * 2267.96185);
      ton = (value * 0.00045359237);
      milligram = (value * 453592.37);
      kilogram = (value / 2.20462262);
      pound = value;
      gram = (value * 453.59237);
      quintal = (value * 0.00453592);

      String mod1 = kilogram.toStringAsFixed(13);
      String mod2 = gram.toStringAsFixed(13);
      String mod3 = quintal.toStringAsFixed(13);
      String mod4 = carat.toStringAsFixed(13);
      String mod5 = ton.toStringAsFixed(13);
      String mod6 = milligram.toStringAsFixed(13);
      String mod7 = microgram.toStringAsFixed(13);

      setState(() {
        isState = true;
        micrograms = "$mod7 Microgram (μg)";
        quintals = "$mod3 Quintal (q)";
        carats = "$mod4 Carat (ct)";
        tons = "$mod5 Ton (t)";
        milligrams = "$mod6 Milligram (mg)";
        kilograms = "$mod1 Kilogram (kg)";
        pounds = "$value Pound (lb)";
        grams = "$mod2 Gram (g)";
      });
    }
  }

  Future<void> loadGeneratedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      grams = prefs.getString(gramKey) ?? "";
      micrograms = prefs.getString(microKey) ?? "";
      quintals = prefs.getString(quinKey) ?? "";
      carats = prefs.getString(caraKey) ?? "";
      tons = prefs.getString(tonKey) ?? "";
      milligrams = prefs.getString(milliKey) ?? "";
      kilograms = prefs.getString(kiloKey) ?? "";
      pounds = prefs.getString(poundKey) ?? "";
      isState = prefs.getBool(stateKey) ?? false;
    });
  }

  Future<void> storeGeneratedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString(gramKey, grams);
    prefs.setString(microKey, micrograms);
    prefs.setString(quinKey, quintals);
    prefs.setString(caraKey, carats);
    prefs.setString(tonKey, tons);
    prefs.setString(milliKey, milligrams);
    prefs.setString(kiloKey, kilograms);
    prefs.setString(poundKey, pounds);
    prefs.setBool(stateKey, isState);
  }

  @override
  void initState() {
    loadGeneratedData();
    super.initState();
  }

  @override
  void dispose() {
    unitController.dispose();
    super.dispose();
  }
}

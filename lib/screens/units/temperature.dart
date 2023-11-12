import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const TemperatureScreen());
}

class TemperatureScreen extends StatelessWidget {
  const TemperatureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AIOPack',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const TemperaturePage(title: 'Temperature Converter'),
    );
  }
}

class TemperaturePage extends StatefulWidget {
  const TemperaturePage({super.key, required this.title});

  final String title;

  @override
  State<TemperaturePage> createState() => _TemperaturePageState();
}

class _TemperaturePageState extends State<TemperaturePage> {
  TextEditingController unitController = TextEditingController();

  late String selectedValue = "Celsius (°C)";

  List<String> dropdownItems = [
    "Celsius (°C)",
    "Fahrenheit (°F)",
    "Kelvin (K)",
    "Rankine (°R)"
  ];

  late double c = 0.0;
  late double f = 0.0;
  late double k = 0.0;
  late double r = 0.0;

  late String cs = "";
  late String fs = "";
  late String ks = "";
  late String rs = "";

  late bool isState = false;

  static const String cKey = "c_key_temp";
  static const String fKey = "f_key_temp";
  static const String kKey = "k_key_temp";
  static const String rKey = "r_key_temp";
  static const String stateKey = "state_key_temp";

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
          centerTitle: true,
          title: Text(widget.title,
              style: const TextStyle(fontWeight: FontWeight.w300)),
          toolbarHeight: 90,
          leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_sharp,
                  color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              }),
          backgroundColor: HexColor("#050A0C"),
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
                                            calculatedTemperatures(data);
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
                                          cs = "";
                                          fs = "";
                                          ks = "";
                                          rs = "";
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
                            Text(cs,
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
                              ),
                            ),
                            Text(fs,
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
                              ),
                            ),
                            Text(ks,
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
                              ),
                            ),
                            Text(rs,
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
                              ),
                            )
                          ]))
                        ])))));
  }

  void calculatedTemperatures(double value) {
    if (selectedValue == "Celsius (°C)") {
      c = value;
      f = (value * 1.8) + 32;
      k = (value + 273.15);
      r = (value + 273.15) * 1.8;

      String mod2 = f.toStringAsFixed(8);
      String mod3 = k.toStringAsFixed(8);
      String mod4 = r.toStringAsFixed(8);

      setState(() {
        isState = true;
        cs = "$value Celsius (°C)";
        fs = "$mod2 Fahrenheit (°F)";
        ks = "$mod3 Kelvin (K)";
        rs = "$mod4 Rankine (°R)";
      });
    }
    if (selectedValue == "Fahrenheit (°F)") {
      c = (value - 32) * (5 / 9);
      f = value;
      k = (value + 459.67) * (5 / 9);
      r = (value + 459.67);

      String mod2 = c.toStringAsFixed(8);
      String mod3 = k.toStringAsFixed(8);
      String mod4 = r.toStringAsFixed(8);

      setState(() {
        isState = true;
        cs = "$mod2 Celsius (°C)";
        fs = "$value Fahrenheit (°F)";
        ks = "$mod3 Kelvin (K)";
        rs = "$mod4 Rankine (°R)";
      });
    }
    if (selectedValue == "Kelvin (K)") {
      c = (value - 273.15);
      f = (value * 1.8) - 459.67;
      k = value;
      r = (value * 1.8);

      String mod2 = f.toStringAsFixed(8);
      String mod3 = c.toStringAsFixed(8);
      String mod4 = r.toStringAsFixed(8);

      setState(() {
        isState = true;
        cs = "$mod3 Celsius (°C)";
        fs = "$mod2 Fahrenheit (°F)";
        ks = "$value Kelvin (K)";
        rs = "$mod4 Rankine (°R)";
      });
    }
    if (selectedValue == "Rankine (°R)") {
      c = (value - 491.67) * (5 / 9);
      f = (value - 459.67);
      k = value * (5 / 9);
      r = value;

      String mod2 = f.toStringAsFixed(8);
      String mod3 = c.toStringAsFixed(8);
      String mod4 = k.toStringAsFixed(8);

      setState(() {
        isState = true;
        cs = "$mod3 Celsius (°C)";
        fs = "$mod2 Fahrenheit (°F)";
        ks = "$mod4 Kelvin (K)";
        rs = "$value Rankine (°R)";
      });
    }
  }

  Future<void> loadGeneratedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      cs = prefs.getString(cKey) ?? "";
      fs = prefs.getString(fKey) ?? "";
      ks = prefs.getString(kKey) ?? "";
      rs = prefs.getString(rKey) ?? "";
      isState = prefs.getBool(stateKey) ?? false;
    });
  }

  Future<void> storeGeneratedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(cKey, cs);
    prefs.setString(fKey, fs);
    prefs.setString(kKey, ks);
    prefs.setString(rKey, rs);
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

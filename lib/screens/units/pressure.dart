import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const PressureScreen());
}

class PressureScreen extends StatelessWidget {
  const PressureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AIOPack',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const PressurePage(title: 'Pressure Converter'),
    );
  }
}

class PressurePage extends StatefulWidget {
  const PressurePage({super.key, required this.title});

  final String title;

  @override
  State<PressurePage> createState() => _PressurePageState();
}

class _PressurePageState extends State<PressurePage> {
  TextEditingController unitController = TextEditingController();

  late String selectedValue = "Atmosphere (atm)";

  List<String> dropdownItems = [
    "Atmosphere (atm)",
    "Bar",
    "Millibar (mbar)",
    "Pascal (pa)",
    "Torr",
    "Pounds/in² (psi)"
  ];

  late double atm = 0.0;
  late double bar = 0.0;
  late double mbar = 0.0;
  late double pa = 0.0;
  late double torr = 0.0;
  late double psi = 0.0;

  late String atms = "";
  late String bars = "";
  late String mbars = "";
  late String pas = "";
  late String torrs = "";
  late String psis = "";

  late bool isState = false;

  static const String atmKey = "atm_key_pres";
  static const String barKey = "bar_key_pres";
  static const String mbarKey = "mbar_key_pres";
  static const String pasKey = "pas_key_pres";
  static const String torrKey = "torr_key_press";
  static const String psiKey = "psi_key_pres";
  static const String stateKey = "state_key_pres";

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
                                            calculatedPressure(data);
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
                                          atms = "";
                                          bars = "";
                                          mbars = "";
                                          pas = "";
                                          torrs = "";
                                          psis = "";
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
                            Text(atms,
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
                            Text(bars,
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
                            Text(mbars,
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
                            Text(pas,
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
                            Text(torrs,
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
                            Text(
                              psis,
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
                              ),
                            ),
                          ]))
                        ])))));
  }

  void calculatedPressure(double value) {
    if (selectedValue == "Atmosphere (atm)") {
      atm = value;
      bar = (value * 1.01325);
      mbar = (value * 1013.25);
      pa = (value * 101325);
      torr = (value * 760.000002);
      psi = (value * 14.6959488);

      String mod1 = bar.toStringAsFixed(8);
      String mod2 = mbar.toStringAsFixed(8);
      String mod3 = pa.toStringAsFixed(8);
      String mod4 = torr.toStringAsFixed(8);
      String mod5 = psi.toStringAsFixed(8);

      setState(() {
        isState = true;
        atms = "$value Atmosphere (atm)";
        bars = "$mod1 Bar";
        mbars = "$mod2 Millibar (mbar)";
        pas = "$mod3 Pascal (pa)";
        torrs = "$mod4 Torr";
        psis = "$mod5 Pounds/in² (psi)";
      });
    }
    if (selectedValue == "Bar") {
      atm = (value / 1.01325);
      bar = value;
      mbar = (value * 1000);
      pa = (value * 100000);
      torr = (value * 750.061685);
      psi = (value * 14.5037738);

      String mod1 = atm.toStringAsFixed(8);
      String mod2 = mbar.toStringAsFixed(8);
      String mod3 = pa.toStringAsFixed(8);
      String mod4 = torr.toStringAsFixed(8);
      String mod5 = psi.toStringAsFixed(8);

      setState(() {
        isState = true;
        atms = "$mod1 Atmosphere (atm)";
        bars = "$value Bar";
        mbars = "$mod2 Millibar (mbar)";
        pas = "$mod3 Pascal (pa)";
        torrs = "$mod4 Torr";
        psis = "$mod5 Pounds/in² (psi)";
      });
    }
    if (selectedValue == "Millibar (mbar)") {
      atm = (value / 1013.25);
      bar = (value / 1000);
      mbar = value;
      pa = (value * 100);
      torr = (value / 1.33322368);
      psi = (value / 68.9475729);

      String mod1 = atm.toStringAsFixed(8);
      String mod2 = bar.toStringAsFixed(8);
      String mod3 = pa.toStringAsFixed(8);
      String mod4 = torr.toStringAsFixed(8);
      String mod5 = psi.toStringAsFixed(8);

      setState(() {
        isState = true;
        atms = "$mod1 Atmosphere (atm)";
        bars = "$mod2 Bar";
        mbars = "$value Millibar (mbar)";
        pas = "$mod3 Pascal (pa)";
        torrs = "$mod4 Torr";
        psis = "$mod5 Pounds/in² (psi)";
      });
    }
    if (selectedValue == "Pascal (pa)") {
      atm = (value / 101325);
      bar = (value / 100000);
      mbar = (value / 100);
      pa = value;
      torr = (value / 133.322368);
      psi = (value / 6894.75729);

      String mod1 = atm.toStringAsFixed(13);
      String mod2 = bar.toStringAsFixed(13);
      String mod3 = mbar.toStringAsFixed(8);
      String mod4 = torr.toStringAsFixed(8);
      String mod5 = psi.toStringAsFixed(8);

      setState(() {
        isState = true;
        atms = "$mod1 Atmosphere (atm)";
        bars = "$mod2 Bar";
        mbars = "$mod3 Millibar (mbar)";
        pas = "$value Pascal (pa)";
        torrs = "$mod4 Torr";
        psis = "$mod5 Pounds/in² (psi)";
      });
    }
    if (selectedValue == "Torr") {
      atm = (value / 760.000002);
      bar = (value / 750.061685);
      mbar = (value * 1.33322368);
      pa = (value * 133.322368);
      torr = value;
      psi = (value / 51.7149327);

      String mod1 = atm.toStringAsFixed(13);
      String mod2 = bar.toStringAsFixed(13);
      String mod3 = mbar.toStringAsFixed(8);
      String mod4 = pa.toStringAsFixed(8);
      String mod5 = psi.toStringAsFixed(8);

      setState(() {
        isState = true;
        atms = "$mod1 Atmosphere (atm)";
        bars = "$mod2 Bar";
        mbars = "$mod3 Millibar (mbar)";
        pas = "$mod4 Pascal (pa)";
        torrs = "$value Torr";
        psis = "$mod5 Pounds/in² (psi)";
      });
    }
    if (selectedValue == "Pounds/in² (psi)") {
      atm = (value / 14.6959488);
      bar = (value / 14.5037738);
      mbar = (value * 68.9475729);
      pa = (value * 6894.75729);
      torr = (value * 51.7149327);
      psi = value;

      String mod1 = atm.toStringAsFixed(13);
      String mod2 = bar.toStringAsFixed(13);
      String mod3 = mbar.toStringAsFixed(8);
      String mod4 = pa.toStringAsFixed(8);
      String mod5 = torr.toStringAsFixed(8);

      setState(() {
        isState = true;
        atms = "$mod1 Atmosphere (atm)";
        bars = "$mod2 Bar";
        mbars = "$mod3 Millibar (mbar)";
        pas = "$mod4 Pascal (pa)";
        torrs = "$mod5 Torr";
        psis = "$value Pounds/in² (psi)";
      });
    }
  }

  Future<void> loadGeneratedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      atms = prefs.getString(atmKey) ?? "";
      bars = prefs.getString(barKey) ?? "";
      mbars = prefs.getString(mbarKey) ?? "";
      pas = prefs.getString(pasKey) ?? "";
      torrs = prefs.getString(torrKey) ?? "";
      psis = prefs.getString(psiKey) ?? "";
      isState = prefs.getBool(stateKey) ?? false;
    });
  }

  Future<void> storeGeneratedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(atmKey, atms);
    prefs.setString(barKey, bars);
    prefs.setString(mbarKey, mbars);
    prefs.setString(pasKey, pas);
    prefs.setString(torrKey, torrs);
    prefs.setString(psiKey, psis);
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

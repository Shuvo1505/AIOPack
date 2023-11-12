import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const SpeedScreen());
}

class SpeedScreen extends StatelessWidget {
  const SpeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AIOPack',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SpeedPage(title: 'Speed Converter'),
    );
  }
}

class SpeedPage extends StatefulWidget {
  const SpeedPage({super.key, required this.title});

  final String title;

  @override
  State<SpeedPage> createState() => _SpeedPageState();
}

class _SpeedPageState extends State<SpeedPage> {
  TextEditingController unitController = TextEditingController();

  late String selectedValue = "Kilometer/hour (km/h)";

  List<String> dropdownItems = [
    "Kilometer/hour (km/h)",
    "Mile/hour (mph)",
    "Mach (ma)",
    "Knot (kn)"
  ];

  late double kmph = 0.0;
  late double mph = 0.0;
  late double mach = 0.0;
  late double knot = 0.0;

  late String kmphs = "";
  late String mphs = "";
  late String machs = "";
  late String knots = "";

  late bool isState = false;

  static const String kmphKey = "kmph_key_spe";
  static const String mphKey = "mph_key_spe";
  static const String machKey = "mach_key_spe";
  static const String knotKey = "knot_key_spe";
  static const String stateKey = "state_key_spe";

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
                                            calculatedSpeeds(data);
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
                                          kmphs = "";
                                          mphs = "";
                                          isState = false;
                                          machs = "";
                                          knots = "";
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
                            Text(kmphs,
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
                            Text(mphs,
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
                            Text(machs,
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
                            Text(knots,
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

  void calculatedSpeeds(double value) {
    if (selectedValue == "Kilometer/hour (km/h)") {
      kmph = value;
      mph = (value / 1.609344);
      mach = (value / 1234.8);
      knot = (value / 1.852);

      String mod2 = mph.toStringAsFixed(8);
      String mod3 = mach.toStringAsFixed(8);
      String mod5 = knot.toStringAsFixed(8);

      setState(() {
        isState = true;
        kmphs = "$value Kilometer/hour (km/h)";
        mphs = "$mod2 Mile/hour (mph)";
        machs = "$mod3 Mach (ma)";
        knots = "$mod5 Knot (kn)";
      });
    }
    if (selectedValue == "Mile/hour (mph)") {
      kmph = (value * 1.609344);
      mph = value;
      mach = (value / 767.269148);
      knot = (value / 1.15077945);

      String mod2 = kmph.toStringAsFixed(8);
      String mod3 = mach.toStringAsFixed(8);
      String mod5 = knot.toStringAsFixed(8);

      setState(() {
        isState = true;
        kmphs = "$mod2 Kilometer/hour (km/h)";
        mphs = "$value Mile/hour (mph)";
        machs = "$mod3 Mach (ma)";
        knots = "$mod5 Knot (kn)";
      });
    }
    if (selectedValue == "Mach (ma)") {
      kmph = (value * 1234.8);
      mph = (value * 767.269148);
      mach = value;
      knot = (value * 666.738661);

      String mod2 = mph.toStringAsFixed(8);
      String mod3 = kmph.toStringAsFixed(8);
      String mod5 = knot.toStringAsFixed(8);

      setState(() {
        isState = true;
        kmphs = "$mod3 Kilometer/hour (km/h)";
        mphs = "$mod2 Mile/hour (mph)";
        machs = "$value Mach (ma)";
        knots = "$mod5 Knot (kn)";
      });
    }
    if (selectedValue == "Knot (kn)") {
      kmph = (value * 1.852);
      mph = (value * 1.15077945);
      mach = (value / 666.738661);
      knot = value;

      String mod2 = mph.toStringAsFixed(8);
      String mod3 = kmph.toStringAsFixed(8);
      String mod5 = mach.toStringAsFixed(8);

      setState(() {
        isState = true;
        kmphs = "$mod3 Kilometer/hour (km/h)";
        mphs = "$mod2 Mile/hour (mph)";
        machs = "$mod5 Mach (ma)";
        knots = "$value Knot (kn)";
      });
    }
  }

  Future<void> loadGeneratedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      kmphs = prefs.getString(kmphKey) ?? "";
      mphs = prefs.getString(mphKey) ?? "";
      machs = prefs.getString(machKey) ?? "";
      knots = prefs.getString(knotKey) ?? "";
      isState = prefs.getBool(stateKey) ?? false;
    });
  }

  Future<void> storeGeneratedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(kmphKey, kmphs);
    prefs.setString(mphKey, mphs);
    prefs.setString(machKey, machs);
    prefs.setString(knotKey, knots);
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

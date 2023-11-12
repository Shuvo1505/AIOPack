import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const VolumeScreen());
}

class VolumeScreen extends StatelessWidget {
  const VolumeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AIOPack',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const VolumePage(title: 'Volume Converter'),
    );
  }
}

class VolumePage extends StatefulWidget {
  const VolumePage({super.key, required this.title});

  final String title;

  @override
  State<VolumePage> createState() => _VolumePageState();
}

class _VolumePageState extends State<VolumePage> {
  TextEditingController unitController = TextEditingController();

  late String selectedValue = "Cubic meter (m³)";

  List<String> dropdownItems = [
    "Cubic meter (m³)",
    "Cubic centimeter (cm³)",
    "Liter (L)",
    "Milliliter (ml)",
    "Cubic foot (ft³)",
    "Cubic inch (in³)",
    "US Gallon (gal)"
  ];

  late double cubicm = 0.0;
  late double cubiccm = 0.0;
  late double liter = 0.0;
  late double milliliter = 0.0;
  late double cubicf = 0.0;
  late double cubicin = 0.0;
  late double gallon = 0.0;

  late String cubicms = "";
  late String cubiccms = "";
  late String liters = "";
  late String milliliters = "";
  late String cubicfs = "";
  late String cubicins = "";
  late String gallons = "";

  late bool isState = false;

  static const String cubicmKey = "cubicm_key_vol";
  static const String cubiccmKey = "cubiccm_key_vol";
  static const String literKey = "liter_key_vol";
  static const String milliKey = "milli_key_vol";
  static const String cubicfKey = "cubicf_key_vol";
  static const String cubicinKey = "cubicin_key_vol";
  static const String gallonKey = "gallon_key_vol";
  static const String stateKey = "state_key_vol";

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
                                            calculatedVolumes(data);
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
                                          cubicms = "";
                                          cubiccms = "";
                                          liters = "";
                                          milliliters = "";
                                          cubicfs = "";
                                          cubicins = "";
                                          isState = false;
                                          gallons = "";
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
                            Text(cubicms,
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
                            Text(cubiccms,
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
                            Text(liters,
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
                            Text(milliliters,
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
                            Text(cubicfs,
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
                              cubicins,
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
                            Text(gallons,
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

  void calculatedVolumes(double value) {
    if (selectedValue == "Cubic meter (m³)") {
      cubicm = value;
      cubiccm = (value * 1000000);
      liter = (value * 1000);
      milliliter = (value * 1000000);
      cubicf = (value * 35.3146667);
      cubicin = (value * 61023.7441);
      gallon = (value * 264.172053);

      String mod2 = cubiccm.toStringAsFixed(13);
      String mod3 = liter.toStringAsFixed(13);
      String mod4 = milliliter.toStringAsFixed(13);
      String mod5 = cubicf.toStringAsFixed(13);
      String mod6 = cubicin.toStringAsFixed(13);
      String mod7 = gallon.toStringAsFixed(13);

      setState(() {
        isState = true;
        cubicms = "$value Cubic meter (m³)";
        cubiccms = "$mod2 Cubic centimeter (cm³)";
        liters = "$mod3 Liter (L)";
        milliliters = "$mod4 Milliliter (ml)";
        cubicfs = "$mod5 Cubic foot (ft³)";
        cubicins = "$mod6 Cubic inch (in³)";
        gallons = "$mod7 Gallon (gal)";
      });
    }
    if (selectedValue == "Cubic centimeter (cm³)") {
      cubicm = (value / 1000000);
      cubiccm = value;
      liter = (value / 1000);
      milliliter = (value * 1);
      cubicf = (value / 28316.8466);
      cubicin = (value / 16.387064);
      gallon = (value / 3785.41178);

      String mod2 = cubicm.toStringAsFixed(13);
      String mod3 = liter.toStringAsFixed(13);
      String mod4 = milliliter.toStringAsFixed(13);
      String mod5 = cubicf.toStringAsFixed(13);
      String mod6 = cubicin.toStringAsFixed(13);
      String mod7 = gallon.toStringAsFixed(13);

      setState(() {
        isState = true;
        cubicms = "$mod2 Cubic meter (m³)";
        cubiccms = "$value Cubic centimeter (cm³)";
        liters = "$mod3 Liter (L)";
        milliliters = "$mod4 Milliliter (ml)";
        cubicfs = "$mod5 Cubic foot (ft³)";
        cubicins = "$mod6 Cubic inch (in³)";
        gallons = "$mod7 Gallon (gal)";
      });
    }
    if (selectedValue == "Liter (L)") {
      cubicm = (value / 1000);
      cubiccm = (value * 1000);
      liter = value;
      milliliter = (value * 1000);
      cubicf = (value / 28.3168466);
      cubicin = (value * 61.0237441);
      gallon = (value / 3.78541178);

      String mod2 = cubicm.toStringAsFixed(13);
      String mod3 = cubiccm.toStringAsFixed(13);
      String mod4 = milliliter.toStringAsFixed(13);
      String mod5 = cubicf.toStringAsFixed(13);
      String mod6 = cubicin.toStringAsFixed(13);
      String mod7 = gallon.toStringAsFixed(13);

      setState(() {
        isState = true;
        cubicms = "$mod2 Cubic meter (m³)";
        cubiccms = "$mod3 Cubic centimeter (cm³)";
        liters = "$value Liter (L)";
        milliliters = "$mod4 Milliliter (ml)";
        cubicfs = "$mod5 Cubic foot (ft³)";
        cubicins = "$mod6 Cubic inch (in³)";
        gallons = "$mod7 Gallon (gal)";
      });
    }
    if (selectedValue == "Milliliter (ml)") {
      cubicm = (value / 1000000);
      cubiccm = (value * 1);
      liter = (value / 1000);
      milliliter = value;
      cubicf = (value / 28316.8466);
      cubicin = (value / 16.387064);
      gallon = (value / 3785.41178);

      String mod2 = cubicm.toStringAsFixed(13);
      String mod3 = cubiccm.toStringAsFixed(13);
      String mod4 = liter.toStringAsFixed(13);
      String mod5 = cubicf.toStringAsFixed(13);
      String mod6 = cubicin.toStringAsFixed(13);
      String mod7 = gallon.toStringAsFixed(13);

      setState(() {
        isState = true;
        cubicms = "$mod2 Cubic meter (m³)";
        cubiccms = "$mod3 Cubic centimeter (cm³)";
        liters = "$mod4 Liter (L)";
        milliliters = "$value Milliliter (ml)";
        cubicfs = "$mod5 Cubic foot (ft³)";
        cubicins = "$mod6 Cubic inch (in³)";
        gallons = "$mod7 Gallon (gal)";
      });
    }
    if (selectedValue == "Cubic foot (ft³)") {
      cubicm = (value / 35.3146667);
      cubiccm = (value * 28316.8466);
      liter = (value * 28.3168466);
      milliliter = (value * 28316.8466);
      cubicf = value;
      cubicin = (value * 1728);
      gallon = (value * 7.48051949);

      String mod2 = cubicm.toStringAsFixed(13);
      String mod3 = liter.toStringAsFixed(13);
      String mod4 = milliliter.toStringAsFixed(13);
      String mod5 = cubiccm.toStringAsFixed(13);
      String mod6 = cubicin.toStringAsFixed(13);
      String mod7 = gallon.toStringAsFixed(13);

      setState(() {
        isState = true;
        cubicms = "$mod2 Cubic meter (m³)";
        cubiccms = "$mod5 Cubic centimeter (cm³)";
        liters = "$mod3 Liter (L)";
        milliliters = "$mod4 Milliliter (ml)";
        cubicfs = "$value Cubic foot (ft³)";
        cubicins = "$mod6 Cubic inch (in³)";
        gallons = "$mod7 Gallon (gal)";
      });
    }
    if (selectedValue == "Cubic inch (in³)") {
      cubicm = (value / 61023.7441);
      cubiccm = (value * 16.387064);
      liter = (value / 61.0237441);
      milliliter = (value * 16.387064);
      cubicf = (value / 1728);
      cubicin = value;
      gallon = (value / 231);

      String mod2 = cubicm.toStringAsFixed(13);
      String mod3 = liter.toStringAsFixed(13);
      String mod4 = milliliter.toStringAsFixed(13);
      String mod5 = cubiccm.toStringAsFixed(13);
      String mod6 = cubicf.toStringAsFixed(13);
      String mod7 = gallon.toStringAsFixed(13);

      setState(() {
        isState = true;
        cubicms = "$mod2 Cubic meter (m³)";
        cubiccms = "$mod5 Cubic centimeter (cm³)";
        liters = "$mod3 Liter (L)";
        milliliters = "$mod4 Milliliter (ml)";
        cubicfs = "$mod6 Cubic foot (ft³)";
        cubicins = "$value Cubic inch (in³)";
        gallons = "$mod7 Gallon (gal)";
      });
    }
    if (selectedValue == "US Gallon (gal)") {
      cubicm = (value / 264.172053);
      cubiccm = (value * 3785.41178);
      liter = (value * 3.78541178);
      milliliter = (value * 3785.41178);
      cubicf = (value / 7.48051949);
      cubicin = (value * 231);
      gallon = value;

      String mod2 = cubicm.toStringAsFixed(13);
      String mod3 = liter.toStringAsFixed(13);
      String mod4 = milliliter.toStringAsFixed(13);
      String mod5 = cubiccm.toStringAsFixed(13);
      String mod6 = cubicf.toStringAsFixed(13);
      String mod7 = cubicin.toStringAsFixed(13);

      setState(() {
        isState = true;
        cubicms = "$mod2 Cubic meter (m³)";
        cubiccms = "$mod5 Cubic centimeter (cm³)";
        liters = "$mod3 Liter (L)";
        milliliters = "$mod4 Milliliter (ml)";
        cubicfs = "$mod6 Cubic foot (ft³)";
        cubicins = "$mod7 Cubic inch (in³)";
        gallons = "$value Gallon (gal)";
      });
    }
  }

  Future<void> loadGeneratedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      cubicms = prefs.getString(cubicmKey) ?? "";
      cubiccms = prefs.getString(cubiccmKey) ?? "";
      liters = prefs.getString(literKey) ?? "";
      milliliters = prefs.getString(milliKey) ?? "";
      cubicfs = prefs.getString(cubicfKey) ?? "";
      cubicins = prefs.getString(cubicinKey) ?? "";
      gallons = prefs.getString(gallonKey) ?? "";
      isState = prefs.getBool(stateKey) ?? false;
    });
  }

  Future<void> storeGeneratedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(cubicmKey, cubicms);
    prefs.setString(cubiccmKey, cubiccms);
    prefs.setString(literKey, liters);
    prefs.setString(milliKey, milliliters);
    prefs.setString(cubicfKey, cubicfs);
    prefs.setString(cubicinKey, cubicins);
    prefs.setString(gallonKey, gallons);
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

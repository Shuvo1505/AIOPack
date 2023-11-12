import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const LengthScreen());
}

class LengthScreen extends StatelessWidget {
  const LengthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AIOPack',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LengthPage(title: 'Length Converter'),
    );
  }
}

class LengthPage extends StatefulWidget {
  const LengthPage({super.key, required this.title});

  final String title;

  @override
  State<LengthPage> createState() => _LengthPageState();
}

class _LengthPageState extends State<LengthPage> {
  TextEditingController unitController = TextEditingController();

  late String selectedValue = "Decimeter (dm)";

  List<String> dropdownItems = [
    "Decimeter (dm)",
    "Millimeter (mm)",
    "Centimeter (cm)",
    "Kilometer (km)",
    "Meter (m)",
    "Nanometer (nm)",
    "Micrometer (μm)",
    "Foot (ft)",
    "Inch (in)",
    "Yard (yd)",
    "Mile (mi)"
  ];

  late double decimeter = 0.0;
  late double milimeter = 0.0;
  late double centimeter = 0.0;
  late double kilometer = 0.0;
  late double meter = 0.0;
  late double nanometer = 0.0;
  late double feet = 0.0;
  late double inch = 0.0;
  late double yard = 0.0;
  late double mile = 0.0;
  late double micrometer = 0.0;

  late String decimeters = "";
  late String milimeters = "";
  late String centimeters = "";
  late String kilometers = "";
  late String meters = "";
  late String nanometers = "";
  late String feets = "";
  late String inchs = "";
  late String yards = "";
  late String miles = "";
  late String micrometers = "";

  late bool isState = false;

  static const String deciKey = "deci_key_len";
  static const String milliKey = "milli_key_len";
  static const String centiKey = "centi_key_len";
  static const String kiloKey = "kilo_key_len";
  static const String meterKey = "meter_key_len";
  static const String nanoKey = "nano_key_len";
  static const String feetKey = "feet_key_len";
  static const String inchKey = "inch_key_len";
  static const String yardKey = "yard_key_len";
  static const String mileKey = "mile_key_len";
  static const String microKey = "micro_key_len";
  static const String stateKey = "state_key_len";

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
                                            calculatedLengths(data);
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
                                          decimeters = "";
                                          milimeters = "";
                                          centimeters = "";
                                          kilometers = "";
                                          meters = "";
                                          nanometers = "";
                                          feets = "";
                                          inchs = "";
                                          yards = "";
                                          miles = "";
                                          micrometers = "";
                                          FocusScope.of(context).unfocus();
                                          isState = false;
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
                            Text(decimeters,
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
                            Text(milimeters,
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
                            Text(centimeters,
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
                            Text(kilometers,
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
                            Text(meters,
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
                              nanometers,
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
                            Text(feets,
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
                            Text(inchs,
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
                            Text(yards,
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
                            Text(miles,
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
                            Text(micrometers,
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
                          ]))
                        ])))));
  }

  void calculatedLengths(double value) {
    if (selectedValue == "Decimeter (dm)") {
      milimeter = (value * 100);
      centimeter = (value * 10);
      kilometer = (value / 10000);
      meter = (value / 10);
      nanometer = (value * 100000000);
      feet = (value / 3.048);
      inch = (value * 3.93700787);
      yard = (value / 9.144);
      micrometer = (value * 10000000);
      mile = (value / 16093.44);
      decimeter = value;

      String mod1 = milimeter.toStringAsFixed(13);
      String mod2 = centimeter.toStringAsFixed(13);
      String mod3 = kilometer.toStringAsFixed(13);
      String mod4 = meter.toStringAsFixed(13);
      String mod5 = nanometer.toStringAsFixed(13);
      String mod6 = feet.toStringAsFixed(13);
      String mod7 = inch.toStringAsFixed(13);
      String mod8 = yard.toStringAsFixed(13);
      String mod9 = micrometer.toStringAsFixed(13);
      String mod10 = mile.toStringAsFixed(13);

      setState(() {
        isState = true;
        milimeters = "$mod1 Millimeter (mm)";
        centimeters = "$mod2 Centimeter (cm)";
        kilometers = "$mod3 Kilometer (km)";
        meters = "$mod4 Meter (m)";
        nanometers = "$mod5 Nanometer (nm)";
        feets = "$mod6 Foot (ft)";
        inchs = "$mod7 Inch (in)";
        yards = "$mod8 Yard (yd)";
        micrometers = "$mod9 Micrometer (μm)";
        miles = "$mod10 Mile (mi)";
        decimeters = "$value Decimeter (dm)";
      });
    }
    if (selectedValue == "Millimeter (mm)") {
      milimeter = value;
      centimeter = (value / 10);
      kilometer = (value / 1000000);
      meter = (value / 1000);
      nanometer = (value * 1000000);
      feet = (value / 304.8);
      inch = (value / 25.4);
      yard = (value / 914.4);
      micrometer = (value * 1000);
      mile = (value / 160934400);
      decimeter = (value / 100);

      String mod1 = decimeter.toStringAsFixed(13);
      String mod2 = centimeter.toStringAsFixed(13);
      String mod3 = kilometer.toStringAsFixed(13);
      String mod4 = meter.toStringAsFixed(13);
      String mod5 = nanometer.toStringAsFixed(13);
      String mod6 = feet.toStringAsFixed(13);
      String mod7 = inch.toStringAsFixed(13);
      String mod8 = yard.toStringAsFixed(13);
      String mod9 = micrometer.toStringAsFixed(13);
      String mod10 = mile.toStringAsFixed(13);

      setState(() {
        isState = true;
        milimeters = "$value Millimeter (mm)";
        centimeters = "$mod2 Centimeter (cm)";
        kilometers = "$mod3 Kilometer (km)";
        meters = "$mod4 Meter (m)";
        nanometers = "$mod5 Nanometer (nm)";
        feets = "$mod6 Foot (ft)";
        inchs = "$mod7 Inch (in)";
        yards = "$mod8 Yard (yd)";
        micrometers = "$mod9 Micrometer (μm)";
        miles = "$mod10 Mile (mi)";
        decimeters = "$mod1 Decimeter (dm)";
      });
    }
    if (selectedValue == "Centimeter (cm)") {
      milimeter = (value * 10);
      centimeter = value;
      kilometer = (value / 100000);
      meter = (value / 100);
      nanometer = (value * 10000000);
      feet = (value / 30.48);
      inch = (value / 2.54);
      yard = (value / 91.44);
      micrometer = (value * 10000);
      mile = (value / 160934.4);
      decimeter = (value / 10);

      String mod1 = decimeter.toStringAsFixed(13);
      String mod2 = milimeter.toStringAsFixed(13);
      String mod3 = kilometer.toStringAsFixed(13);
      String mod4 = meter.toStringAsFixed(13);
      String mod5 = nanometer.toStringAsFixed(13);
      String mod6 = feet.toStringAsFixed(13);
      String mod7 = inch.toStringAsFixed(13);
      String mod8 = yard.toStringAsFixed(13);
      String mod9 = micrometer.toStringAsFixed(13);
      String mod10 = mile.toStringAsFixed(13);

      setState(() {
        isState = true;
        milimeters = "$mod2 Millimeter (mm)";
        centimeters = "$value Centimeter (cm)";
        kilometers = "$mod3 Kilometer (km)";
        meters = "$mod4 Meter (m)";
        nanometers = "$mod5 Nanometer (nm)";
        feets = "$mod6 Foot (ft)";
        inchs = "$mod7 Inch (in)";
        yards = "$mod8 Yard (yd)";
        micrometers = "$mod9 Micrometer (μm)";
        miles = "$mod10 Mile (mi)";
        decimeters = "$mod1 Decimeter (dm)";
      });
    }
    if (selectedValue == "Kilometer (km)") {
      milimeter = (value * 1000000);
      centimeter = (value * 100000);
      kilometer = value;
      meter = (value * 1000);
      nanometer = (value * 1000000000000);
      feet = (value * 3280.8399);
      inch = (value * 39370.0787);
      yard = (value * 1093.6133);
      micrometer = (value * 1000000);
      mile = (value / 1.609344);
      decimeter = (value * 10000);

      String mod1 = decimeter.toStringAsFixed(13);
      String mod2 = milimeter.toStringAsFixed(13);
      String mod3 = centimeter.toStringAsFixed(13);
      String mod4 = meter.toStringAsFixed(13);
      String mod5 = nanometer.toStringAsFixed(13);
      String mod6 = feet.toStringAsFixed(13);
      String mod7 = inch.toStringAsFixed(13);
      String mod8 = yard.toStringAsFixed(13);
      String mod9 = micrometer.toStringAsFixed(13);
      String mod10 = mile.toStringAsFixed(13);

      setState(() {
        isState = true;
        milimeters = "$mod2 Millimeter (mm)";
        centimeters = "$mod3 Centimeter (cm)";
        kilometers = "$value Kilometer (km)";
        meters = "$mod4 Meter (m)";
        nanometers = "$mod5 Nanometer (nm)";
        feets = "$mod6 Foot (ft)";
        inchs = "$mod7 Inch (in)";
        yards = "$mod8 Yard (yd)";
        micrometers = "$mod9 Micrometer (μm)";
        miles = "$mod10 Mile (mi)";
        decimeters = "$mod1 Decimeter (dm)";
      });
    }
    if (selectedValue == "Meter (m)") {
      milimeter = (value * 1000);
      centimeter = (value * 100);
      kilometer = (value / 1000);
      meter = value;
      nanometer = (value * 1000000000);
      feet = (value * 3.2808399);
      inch = (value * 39.3700787);
      yard = (value * 1.0936133);
      micrometer = (value * 1000000);
      mile = (value / 1609.344);
      decimeter = (value * 10);

      String mod1 = decimeter.toStringAsFixed(13);
      String mod2 = milimeter.toStringAsFixed(13);
      String mod3 = centimeter.toStringAsFixed(13);
      String mod4 = kilometer.toStringAsFixed(13);
      String mod5 = nanometer.toStringAsFixed(13);
      String mod6 = feet.toStringAsFixed(13);
      String mod7 = inch.toStringAsFixed(13);
      String mod8 = yard.toStringAsFixed(13);
      String mod9 = micrometer.toStringAsFixed(13);
      String mod10 = mile.toStringAsFixed(13);

      setState(() {
        isState = true;
        milimeters = "$mod2 Millimeter (mm)";
        centimeters = "$mod3 Centimeter (cm)";
        kilometers = "$mod4 Kilometer (km)";
        meters = "$value Meter (m)";
        nanometers = "$mod5 Nanometer (nm)";
        feets = "$mod6 Foot (ft)";
        inchs = "$mod7 Inch (in)";
        yards = "$mod8 Yard (yd)";
        micrometers = "$mod9 Micrometer (μm)";
        miles = "$mod10 Mile (mi)";
        decimeters = "$mod1 Decimeter (dm)";
      });
    }
    if (selectedValue == "Nanometer (nm)") {
      milimeter = (value / 1000000);
      centimeter = (value / 10000000);
      kilometer = (value / 1000000000000);
      meter = (value / 1000000000);
      nanometer = value;
      feet = (value / 304800000);
      inch = (value / 25400000);
      yard = (value / 914400000);
      micrometer = (value / 1000);
      mile = (value / 1609300000000);
      decimeter = (value / 100000000);

      String mod1 = decimeter.toStringAsFixed(13);
      String mod2 = milimeter.toStringAsFixed(13);
      String mod3 = centimeter.toStringAsFixed(13);
      String mod4 = kilometer.toStringAsFixed(13);
      String mod5 = meter.toStringAsFixed(13);
      String mod6 = feet.toStringAsFixed(13);
      String mod7 = inch.toStringAsFixed(13);
      String mod8 = yard.toStringAsFixed(13);
      String mod9 = micrometer.toStringAsFixed(13);
      String mod10 = mile.toStringAsFixed(13);

      setState(() {
        isState = true;
        milimeters = "$mod2 Millimeter (mm)";
        centimeters = "$mod3 Centimeter (cm)";
        kilometers = "$mod4 Kilometer (km)";
        meters = "$mod5 Meter (m)";
        nanometers = "$value Nanometer (nm)";
        feets = "$mod6 Foot (ft)";
        inchs = "$mod7 Inch (in)";
        yards = "$mod8 Yard (yd)";
        micrometers = "$mod9 Micrometer (μm)";
        miles = "$mod10 Mile (mi)";
        decimeters = "$mod1 Decimeter (dm)";
      });
    }
    if (selectedValue == "Micrometer (μm)") {
      milimeter = (value / 1000);
      centimeter = (value / 10000);
      kilometer = (value / 1000000000);
      meter = (value / 1000000);
      nanometer = (value * 1000);
      feet = (value * 0.00000328084);
      inch = (value * 0.0000393701);
      yard = (value * 0.00000109361);
      micrometer = value;
      mile = (value * 0.00000000000062137);
      decimeter = (value * 0.0001);

      String mod1 = decimeter.toStringAsFixed(13);
      String mod2 = milimeter.toStringAsFixed(13);
      String mod3 = centimeter.toStringAsFixed(13);
      String mod4 = kilometer.toStringAsFixed(13);
      String mod5 = meter.toStringAsFixed(13);
      String mod6 = feet.toStringAsFixed(13);
      String mod7 = inch.toStringAsFixed(13);
      String mod8 = yard.toStringAsFixed(13);
      String mod9 = nanometer.toStringAsFixed(13);
      String mod10 = mile.toStringAsFixed(13);

      setState(() {
        isState = true;
        milimeters = "$mod2 Millimeter (mm)";
        centimeters = "$mod3 Centimeter (cm)";
        kilometers = "$mod4 Kilometer (km)";
        meters = "$mod5 Meter (m)";
        nanometers = "$mod9 Nanometer (nm)";
        feets = "$mod6 Foot (ft)";
        inchs = "$mod7 Inch (in)";
        yards = "$mod8 Yard (yd)";
        micrometers = "$value Micrometer (μm)";
        miles = "$mod10 Mile (mi)";
        decimeters = "$mod1 Decimeter (dm)";
      });
    }
    if (selectedValue == "Foot (ft)") {
      milimeter = (value * 304.8);
      centimeter = (value * 30.48);
      kilometer = (value / 3280.8399);
      meter = (value / 3.2808399);
      nanometer = (value * 304800000);
      feet = value;
      inch = (value * 12);
      yard = (value / 3);
      micrometer = (value * 304800);
      mile = (value / 5280);
      decimeter = (value * 3.048);

      String mod1 = decimeter.toStringAsFixed(13);
      String mod2 = milimeter.toStringAsFixed(13);
      String mod3 = centimeter.toStringAsFixed(13);
      String mod4 = kilometer.toStringAsFixed(13);
      String mod5 = meter.toStringAsFixed(13);
      String mod6 = micrometer.toStringAsFixed(13);
      String mod7 = inch.toStringAsFixed(13);
      String mod8 = yard.toStringAsFixed(13);
      String mod9 = nanometer.toStringAsFixed(13);
      String mod10 = mile.toStringAsFixed(13);

      setState(() {
        isState = true;
        milimeters = "$mod2 Millimeter (mm)";
        centimeters = "$mod3 Centimeter (cm)";
        kilometers = "$mod4 Kilometer (km)";
        meters = "$mod5 Meter (m)";
        nanometers = "$mod9 Nanometer (nm)";
        feets = "$value Foot (ft)";
        inchs = "$mod7 Inch (in)";
        yards = "$mod8 Yard (yd)";
        micrometers = "$mod6 Micrometer (μm)";
        miles = "$mod10 Mile (mi)";
        decimeters = "$mod1 Decimeter (dm)";
      });
    }
    if (selectedValue == "Inch (in)") {
      milimeter = (value * 25.4);
      centimeter = (value * 2.54);
      kilometer = (value / 39370.0787);
      meter = (value / 39.3700787);
      nanometer = (value * 25400000);
      feet = (value / 12);
      inch = value;
      yard = (value / 36);
      micrometer = (value * 25400);
      mile = (value / 63360);
      decimeter = (value / 3.93700787);

      String mod1 = decimeter.toStringAsFixed(13);
      String mod2 = milimeter.toStringAsFixed(13);
      String mod3 = centimeter.toStringAsFixed(13);
      String mod4 = kilometer.toStringAsFixed(13);
      String mod5 = meter.toStringAsFixed(13);
      String mod6 = micrometer.toStringAsFixed(13);
      String mod7 = feet.toStringAsFixed(13);
      String mod8 = yard.toStringAsFixed(13);
      String mod9 = nanometer.toStringAsFixed(13);
      String mod10 = mile.toStringAsFixed(13);

      setState(() {
        isState = true;
        milimeters = "$mod2 Millimeter (mm)";
        centimeters = "$mod3 Centimeter (cm)";
        kilometers = "$mod4 Kilometer (km)";
        meters = "$mod5 Meter (m)";
        nanometers = "$mod9 Nanometer (nm)";
        feets = "$mod7 Foot (ft)";
        inchs = "$value Inch (in)";
        yards = "$mod8 Yard (yd)";
        micrometers = "$mod6 Micrometer (μm)";
        miles = "$mod10 Mile (mi)";
        decimeters = "$mod1 Decimeter (dm)";
      });
    }
    if (selectedValue == "Yard (yd)") {
      milimeter = (value * 914.4);
      centimeter = (value * 9.144);
      kilometer = (value / 1093.6133);
      meter = (value / 1.0936133);
      nanometer = (value * 914400000);
      feet = (value * 3);
      inch = (value * 36);
      yard = value;
      micrometer = (value * 914400);
      mile = (value / 1760);
      decimeter = (value * 9.144);

      String mod1 = decimeter.toStringAsFixed(13);
      String mod2 = milimeter.toStringAsFixed(13);
      String mod3 = centimeter.toStringAsFixed(13);
      String mod4 = kilometer.toStringAsFixed(13);
      String mod5 = meter.toStringAsFixed(13);
      String mod6 = micrometer.toStringAsFixed(13);
      String mod7 = feet.toStringAsFixed(13);
      String mod8 = inch.toStringAsFixed(13);
      String mod9 = nanometer.toStringAsFixed(13);
      String mod10 = mile.toStringAsFixed(13);

      setState(() {
        isState = true;
        milimeters = "$mod2 Millimeter (mm)";
        centimeters = "$mod3 Centimeter (cm)";
        kilometers = "$mod4 Kilometer (km)";
        meters = "$mod5 Meter (m)";
        nanometers = "$mod9 Nanometer (nm)";
        feets = "$mod7 Foot (ft)";
        inchs = "$mod8 Inch (in)";
        yards = "$value Yard (yd)";
        micrometers = "$mod6 Micrometer (μm)";
        miles = "$mod10 Mile (mi)";
        decimeters = "$mod1 Decimeter (dm)";
      });
    }
    if (selectedValue == "Mile (mi)") {
      milimeter = (value * 1609300);
      centimeter = (value * 160934.4);
      kilometer = (value * 1.609344);
      meter = (value * 1609.344);
      nanometer = (value * 1609300000000);
      feet = (value * 5280);
      inch = (value * 63360);
      yard = (value * 1760);
      micrometer = (value * 1609344000);
      mile = value;
      decimeter = (value * 16093.44);

      String mod1 = decimeter.toStringAsFixed(13);
      String mod2 = milimeter.toStringAsFixed(13);
      String mod3 = centimeter.toStringAsFixed(13);
      String mod4 = kilometer.toStringAsFixed(13);
      String mod5 = meter.toStringAsFixed(13);
      String mod6 = micrometer.toStringAsFixed(13);
      String mod7 = feet.toStringAsFixed(13);
      String mod8 = inch.toStringAsFixed(13);
      String mod9 = nanometer.toStringAsFixed(13);
      String mod10 = yard.toStringAsFixed(13);

      setState(() {
        isState = true;
        milimeters = "$mod2 Millimeter (mm)";
        centimeters = "$mod3 Centimeter (cm)";
        kilometers = "$mod4 Kilometer (km)";
        meters = "$mod5 Meter (m)";
        nanometers = "$mod9 Nanometer (nm)";
        feets = "$mod7 Foot (ft)";
        inchs = "$mod8 Inch (in)";
        yards = "$mod10 Yard (yd)";
        micrometers = "$mod6 Micrometer (μm)";
        miles = "$value Mile (mi)";
        decimeters = "$mod1 Decimeter (dm)";
      });
    }
  }

  Future<void> loadGeneratedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      decimeters = prefs.getString(deciKey) ?? "";
      milimeters = prefs.getString(milliKey) ?? "";
      centimeters = prefs.getString(centiKey) ?? "";
      kilometers = prefs.getString(kiloKey) ?? "";
      meters = prefs.getString(meterKey) ?? "";
      nanometers = prefs.getString(nanoKey) ?? "";
      feets = prefs.getString(feetKey) ?? "";
      inchs = prefs.getString(inchKey) ?? "";
      yards = prefs.getString(yardKey) ?? "";
      miles = prefs.getString(mileKey) ?? "";
      micrometers = prefs.getString(microKey) ?? "";
      isState = prefs.getBool(stateKey) ?? false;
    });
  }

  Future<void> storeGeneratedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString(deciKey, decimeters);
    prefs.setString(milliKey, milimeters);
    prefs.setString(centiKey, centimeters);
    prefs.setString(kiloKey, kilometers);
    prefs.setString(meterKey, meters);
    prefs.setString(nanoKey, nanometers);
    prefs.setString(feetKey, feets);
    prefs.setString(inchKey, inchs);
    prefs.setString(yardKey, yards);
    prefs.setString(mileKey, miles);
    prefs.setString(microKey, micrometers);
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

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const DataScreen());
}

class DataScreen extends StatelessWidget {
  const DataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AIOPack',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const DataPage(title: 'Data Converter'),
    );
  }
}

class DataPage extends StatefulWidget {
  const DataPage({super.key, required this.title});

  final String title;

  @override
  State<DataPage> createState() => _DataPageState();
}

class _DataPageState extends State<DataPage> {
  TextEditingController unitController = TextEditingController();

  late String selectedValue = "Kilobyte (KB)";

  List<String> dropdownItems = [
    "Kilobyte (KB)",
    "Megabyte (MB)",
    "Bytes",
    "Gigabyte (GB)",
    "Terabyte (TB)"
  ];

  late double kb = 0.0;
  late double mb = 0.0;
  late double byte = 0.0;
  late double gb = 0.0;
  late double tb = 0.0;

  late String kbs = "";
  late String mbs = "";
  late String bytes = "";
  late String gbs = "";
  late String tbs = "";

  late bool isState = false;

  static const String kbKey = "kb_key_dat";
  static const String mbKey = "mb_key_dat";
  static const String byKey = "by_key_dat";
  static const String gbKey = "gb_key_dat";
  static const String tbKey = "tb_key_dat";
  static const String stateKey = "state_key_dat";

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
                                            calculatedData(data);
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
                                          kbs = "";
                                          mbs = "";
                                          bytes = "";
                                          gbs = "";
                                          tbs = "";
                                          FocusScope.of(context).unfocus();
                                          selectedValue = dropdownItems[0];
                                          unitController.clear();
                                          isState = false;
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
                            Text(kbs,
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
                            Text(mbs,
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
                            Text(bytes,
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
                            Text(gbs,
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
                              tbs,
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

  void calculatedData(double value) {
    if (selectedValue == "Kilobyte (KB)") {
      kb = value;
      mb = (value / 1000);
      byte = (value * 1000);
      gb = (value / 1000000);
      tb = (value / 1000000000);

      String mod2 = mb.toStringAsFixed(13);
      String mod3 = byte.toStringAsFixed(13);
      String mod5 = gb.toStringAsFixed(13);
      String mod6 = tb.toStringAsFixed(13);

      setState(() {
        isState = true;
        kbs = "$value Kilobyte (KB)";
        mbs = "$mod2 Megabyte (MB)";
        bytes = "$mod3 Bytes";
        gbs = "$mod5 Gigabyte (GB)";
        tbs = "$mod6 Terabyte (TB)";
      });
    }
    if (selectedValue == "Megabyte (MB)") {
      kb = (value * 1000);
      mb = value;
      byte = (value * 1000000);
      gb = (value / 1000);
      tb = (value / 1000000);

      String mod2 = kb.toStringAsFixed(13);
      String mod3 = byte.toStringAsFixed(13);
      String mod5 = gb.toStringAsFixed(13);
      String mod6 = tb.toStringAsFixed(13);

      setState(() {
        isState = true;
        kbs = "$mod2 Kilobyte (KB)";
        mbs = "$value Megabyte (MB)";
        bytes = "$mod3 Bytes";
        gbs = "$mod5 Gigabyte (GB)";
        tbs = "$mod6 Terabyte (TB)";
      });
    }
    if (selectedValue == "Bytes") {
      kb = (value / 1000);
      mb = (value / 1000000);
      byte = value;
      gb = (value / 1000000000);
      tb = (value / 1000000000000);

      String mod2 = kb.toStringAsFixed(13);
      String mod3 = mb.toStringAsFixed(13);
      String mod5 = gb.toStringAsFixed(13);
      String mod6 = tb.toStringAsFixed(16);

      setState(() {
        isState = true;
        kbs = "$mod2 Kilobyte (KB)";
        mbs = "$mod3 Megabyte (MB)";
        bytes = "$value Bytes";
        gbs = "$mod5 Gigabyte (GB)";
        tbs = "$mod6 Terabyte (TB)";
      });
    }
    if (selectedValue == "Gigabyte (GB)") {
      kb = (value * 1000000);
      mb = (value * 1000);
      byte = (value * 1000000000);
      gb = value;
      tb = (value / 1000);

      String mod2 = kb.toStringAsFixed(13);
      String mod3 = mb.toStringAsFixed(13);
      String mod5 = byte.toStringAsFixed(13);
      String mod6 = tb.toStringAsFixed(13);

      setState(() {
        isState = true;
        kbs = "$mod2 Kilobyte (KB)";
        mbs = "$mod3 Megabyte (MB)";
        bytes = "$mod5 Bytes";
        gbs = "$value Gigabyte (GB)";
        tbs = "$mod6 Terabyte (TB)";
      });
    }
    if (selectedValue == "Terabyte (TB)") {
      kb = (value * 1000000000);
      mb = (value * 1000000);
      byte = (value * 1000000000000);
      gb = (value * 1000);
      tb = value;

      String mod2 = kb.toStringAsFixed(8);
      String mod3 = mb.toStringAsFixed(8);
      String mod5 = byte.toStringAsFixed(8);
      String mod6 = gb.toStringAsFixed(8);

      setState(() {
        isState = true;
        kbs = "$mod2 Kilobyte (KB)";
        mbs = "$mod3 Megabyte (MB)";
        bytes = "$mod5 Bytes";
        gbs = "$mod6 Gigabyte (GB)";
        tbs = "$value Terabyte (TB)";
      });
    }
  }

  Future<void> loadGeneratedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      kbs = prefs.getString(kbKey) ?? "";
      mbs = prefs.getString(mbKey) ?? "";
      bytes = prefs.getString(byKey) ?? "";
      gbs = prefs.getString(gbKey) ?? "";
      tbs = prefs.getString(tbKey) ?? "";
      isState = prefs.getBool(stateKey) ?? false;
    });
  }

  Future<void> storeGeneratedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(kbKey, kbs);
    prefs.setString(mbKey, mbs);
    prefs.setString(byKey, bytes);
    prefs.setString(gbKey, gbs);
    prefs.setString(tbKey, tbs);
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

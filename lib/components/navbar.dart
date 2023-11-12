import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

import '../screens/health/bmr.dart';
import '../screens/options/about.dart';
import '../screens/options/bugreport.dart';
import '../screens/options/feedback.dart';
import '../screens/units/data.dart';
import '../screens/units/length.dart';
import '../screens/units/power.dart';
import '../screens/units/pressure.dart';
import '../screens/units/speed.dart';
import '../screens/units/temperature.dart';
import '../screens/units/volume.dart';
import '../screens/units/weight.dart';

class NavScreen extends StatelessWidget {
  const NavScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AIOPack',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const NavPage(),
    );
  }
}

class NavPage extends StatefulWidget {
  const NavPage({super.key});

  @override
  State<NavPage> createState() => _NavPageState();
}

class _NavPageState extends State<NavPage> {
  late bool isBMRSelect = false;
  late bool isLengthSelect = false;
  late bool isWeightSelect = false;
  late bool isVolumeSelect = false;
  late bool isDataSelect = false;
  late bool isSpeedSelect = false;
  late bool isPowerSelect = false;
  late bool isTemperatureSelect = false;
  late bool isPressureSelect = false;
  late bool isBugSelect = false;
  late bool isFeedbackSelect = false;
  late bool isAboutSelect = false;
  late bool isExitSelect = false;

  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: HexColor("#1f1f1f"),
        child: ListView(padding: EdgeInsets.zero, children: [
          const SizedBox(height: 18),
          Row(
            children: [
              Container(
                  margin: const EdgeInsets.only(top: 28, left: 12, bottom: 16),
                  child: const Text("AIOPack",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold))),
            ],
          ),
          const Divider(thickness: 2, color: Colors.grey),
          Container(
              margin: const EdgeInsets.all(12.0),
              child: const Row(children: [
                Text("Health Calculators",
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontWeight: FontWeight.bold))
              ])),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              // You can adjust the value as needed
              color: HexColor("#45494c"),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    // You can adjust the value as needed
                    color: HexColor("#e50914"),
                  ),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: ListTile(
                    leading: const Icon(Icons.directions_walk,
                        color: Colors.white, size: 30),
                    enableFeedback: true,
                    title: const Text("BMI Calculator",
                        style: TextStyle(color: Colors.white, fontSize: 16)),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      // You can adjust the value as needed
                      color: isBMRSelect == true
                          ? HexColor("#e50914")
                          : Colors.transparent),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: ListTile(
                    enableFeedback: true,
                    leading: const Icon(Icons.local_fire_department,
                        color: Colors.white, size: 30),
                    title: const Text("BMR Calculator",
                        style: TextStyle(color: Colors.white, fontSize: 16)),
                    onTap: () {
                      setState(() {
                        isBMRSelect = true;
                      });
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const BMRPage(
                                    title: "BMR Calculator",
                                  )));
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Container(
              margin: const EdgeInsets.all(12.0),
              child: const Row(children: [
                Text("Unit Converters",
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontWeight: FontWeight.bold))
              ])),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                // You can adjust the value as needed
                color: isLengthSelect == true
                    ? HexColor("#e50914")
                    : HexColor("#45494c")),
            margin: const EdgeInsets.only(bottom: 12, left: 10, right: 10),
            child: Container(
              margin: const EdgeInsets.all(10),
              child: ListTile(
                enableFeedback: true,
                leading: const Icon(Icons.linear_scale,
                    color: Colors.white, size: 30),
                title: const Text("Length",
                    style: TextStyle(color: Colors.white, fontSize: 16)),
                onTap: () {
                  setState(() {
                    isLengthSelect = true;
                  });
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LengthPage(
                                title: "Length Converter",
                              )));
                },
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                // You can adjust the value as needed
                color: isWeightSelect == true
                    ? HexColor("#e50914")
                    : HexColor("#45494c")),
            margin: const EdgeInsets.only(bottom: 12, left: 10, right: 10),
            child: Container(
              margin: const EdgeInsets.all(10),
              child: ListTile(
                enableFeedback: true,
                leading: const Icon(Icons.monitor_weight_rounded,
                    color: Colors.white, size: 30),
                title: const Text("Weight",
                    style: TextStyle(color: Colors.white, fontSize: 16)),
                onTap: () {
                  setState(() {
                    isWeightSelect = true;
                  });
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const WeightPage(
                                title: "Weight Converter",
                              )));
                },
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                // You can adjust the value as needed
                color: HexColor("#45494c")),
            margin: const EdgeInsets.only(left: 10, right: 10, bottom: 12),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    // You can adjust the value as needed
                    color: isVolumeSelect == true
                        ? HexColor("#e50914")
                        : HexColor("#45494c"),
                  ),
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    enableFeedback: true,
                    leading: const Icon(Icons.water_drop_rounded,
                        color: Colors.white, size: 30),
                    title: const Text("Volume",
                        style: TextStyle(color: Colors.white, fontSize: 16)),
                    onTap: () {
                      setState(() {
                        isVolumeSelect = true;
                      });
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const VolumePage(
                                    title: "Volume Converter",
                                  )));
                    },
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      // You can adjust the value as needed
                      color: isDataSelect == true
                          ? HexColor("#e50914")
                          : HexColor("#45494c")),
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    enableFeedback: true,
                    leading: const Icon(Icons.data_usage,
                        color: Colors.white, size: 30),
                    title: const Text("Data",
                        style: TextStyle(color: Colors.white, fontSize: 16)),
                    onTap: () {
                      setState(() {
                        isDataSelect = true;
                      });
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const DataPage(
                                    title: "Data Converter",
                                  )));
                    },
                  ),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                // You can adjust the value as needed
                color: isSpeedSelect == true
                    ? HexColor("#e50914")
                    : HexColor("#45494c")),
            margin: const EdgeInsets.only(left: 10, right: 10, bottom: 12),
            child: Container(
              margin: const EdgeInsets.all(10),
              child: ListTile(
                enableFeedback: true,
                leading: const Icon(Icons.speed_rounded,
                    color: Colors.white, size: 30),
                title: const Text("Speed",
                    style: TextStyle(color: Colors.white, fontSize: 16)),
                onTap: () {
                  setState(() {
                    isSpeedSelect = true;
                  });
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SpeedPage(
                                title: "Speed Converter",
                              )));
                },
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                // You can adjust the value as needed
                color: HexColor("#45494c")),
            margin: const EdgeInsets.only(left: 10, right: 10, bottom: 12),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      // You can adjust the value as needed
                      color: isPowerSelect == true
                          ? HexColor("#e50914")
                          : HexColor("#45494c")),
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    enableFeedback: true,
                    leading:
                        const Icon(Icons.power, color: Colors.white, size: 30),
                    title: const Text("Power",
                        style: TextStyle(color: Colors.white, fontSize: 16)),
                    onTap: () {
                      setState(() {
                        isPowerSelect = true;
                      });
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PowerPage(
                                    title: "Power Converter",
                                  )));
                    },
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      // You can adjust the value as needed
                      color: HexColor("#45494c")),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      // You can adjust the value as needed
                      color: isTemperatureSelect == true
                          ? HexColor("#e50914")
                          : HexColor("#45494c"),
                    ),
                    margin: const EdgeInsets.all(10),
                    child: ListTile(
                      enableFeedback: true,
                      leading: const Icon(Icons.thermostat,
                          color: Colors.white, size: 30),
                      title: const Text("Temperature",
                          style: TextStyle(color: Colors.white, fontSize: 16)),
                      onTap: () {
                        setState(() {
                          isTemperatureSelect = true;
                        });
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const TemperaturePage(
                                      title: "Temperature Converter",
                                    )));
                      },
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      // You can adjust the value as needed
                      color: HexColor("#45494c")),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      // You can adjust the value as needed
                      color: isPressureSelect == true
                          ? HexColor("#e50914")
                          : HexColor("#45494c"),
                    ),
                    margin: const EdgeInsets.all(10),
                    child: ListTile(
                      enableFeedback: true,
                      leading: const Icon(Icons.compress,
                          color: Colors.white, size: 30),
                      title: const Text("Pressure",
                          style: TextStyle(color: Colors.white, fontSize: 16)),
                      onTap: () {
                        setState(() {
                          isPressureSelect = true;
                        });
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const PressurePage(
                                      title: "Pressure Converter",
                                    )));
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Container(
              margin: const EdgeInsets.all(12.0),
              child: const Row(children: [
                Text("Options",
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontWeight: FontWeight.bold))
              ])),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                // You can adjust the value as needed
                color: HexColor("#45494c")),
            margin: const EdgeInsets.only(left: 10, right: 10, bottom: 12),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    // You can adjust the value as needed
                    color: isBugSelect == true
                        ? HexColor("#e50914")
                        : HexColor("#45494c"),
                  ),
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    enableFeedback: true,
                    leading: const Icon(Icons.bug_report,
                        color: Colors.white, size: 30),
                    title: const Text("Report problems",
                        style: TextStyle(color: Colors.white, fontSize: 16)),
                    onTap: () {
                      setState(() {
                        isBugSelect = true;
                      });
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const BugPage(
                                    title: "Bug Report",
                                  )));
                    },
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      // You can adjust the value as needed
                      color: HexColor("#45494c")),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      // You can adjust the value as needed
                      color: isFeedbackSelect == true
                          ? HexColor("#e50914")
                          : HexColor("#45494c"),
                    ),
                    margin: const EdgeInsets.all(10),
                    child: ListTile(
                      enableFeedback: true,
                      leading: const Icon(Icons.feedback,
                          color: Colors.white, size: 30),
                      title: const Text("Send a feedback",
                          style: TextStyle(color: Colors.white, fontSize: 16)),
                      onTap: () {
                        setState(() {
                          isFeedbackSelect = true;
                        });
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const FeedbackPage(
                                      title: "Feedback Section",
                                    )));
                      },
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      // You can adjust the value as needed
                      color: HexColor("#45494c")),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      // You can adjust the value as needed
                      color: isAboutSelect == true
                          ? HexColor("#e50914")
                          : HexColor("#45494c"),
                    ),
                    margin: const EdgeInsets.all(10),
                    child: ListTile(
                      enableFeedback: true,
                      leading:
                          const Icon(Icons.info, color: Colors.white, size: 30),
                      title: const Text("About this app",
                          style: TextStyle(color: Colors.white, fontSize: 16)),
                      onTap: () {
                        setState(() {
                          isAboutSelect = true;
                        });
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AboutPage(
                                      title: "About Section",
                                    )));
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                // You can adjust the value as needed
                color: isExitSelect == true
                    ? HexColor("#e50914")
                    : HexColor("#45494c")),
            margin: const EdgeInsets.only(left: 10, right: 10),
            child: Container(
              margin: const EdgeInsets.all(10),
              child: ListTile(
                enableFeedback: true,
                leading: const Icon(Icons.power_settings_new_rounded,
                    color: Colors.white, size: 30),
                title: const Text("Exit from this app",
                    style: TextStyle(color: Colors.white, fontSize: 16)),
                onTap: () {
                  setState(() {
                    isExitSelect = true;
                  });
                  Navigator.pop(context);
                  showDialog(
                      barrierDismissible: true,
                      context: context,
                      builder: (context) => AlertDialog(
                          title: const Text(
                            "Do you want to exit ?",
                            style: TextStyle(color: Colors.white),
                          ),
                          content: const SizedBox(height: 4),
                          actions: [
                            SizedBox(
                              width: 74,
                              child: MaterialButton(
                                  onPressed: () {
                                    SystemNavigator.pop();
                                  },
                                  color: HexColor("#1f1f1f"),
                                  elevation: 0.0,
                                  shape: const ContinuousRectangleBorder(
                                      side: BorderSide.none),
                                  child: Text("Yes",
                                      style: TextStyle(
                                          color: HexColor("#e50914"),
                                          fontSize: 16))),
                            ),
                            const SizedBox(width: 6),
                            SizedBox(
                              width: 74,
                              child: MaterialButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  shape: ContinuousRectangleBorder(
                                      side: BorderSide.none,
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                  color: HexColor("#028A0F"),
                                  elevation: 0.0,
                                  child: const Text("No",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16))),
                            ),
                          ],
                          elevation: 24,
                          backgroundColor: HexColor("#1f1f1f")));
                },
              ),
            ),
          ),
          const SizedBox(height: 18)
        ]));
  }
}

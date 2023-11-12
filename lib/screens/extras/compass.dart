import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:flutter_sensors/flutter_sensors.dart';
import 'package:hexcolor/hexcolor.dart';

void main() {
  runApp(const CompassScreen());
}

class CompassScreen extends StatelessWidget {
  const CompassScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AIOPack',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const CompassPage(),
    );
  }
}

class CompassPage extends StatefulWidget {
  const CompassPage({super.key});

  @override
  State<CompassPage> createState() => _CompassPageState();
}

class _CompassPageState extends State<CompassPage> {
  late double? heading = 0;
  late String error = "";

  @override
  void initState() {
    super.initState();
    try {
      checkSensorAvailable();
      FlutterCompass.events!.listen((event) {
        setState(() {
          heading = event.heading;
        });
      });
    } on Exception {
      setState(() {
        error = "Faulty Sensor";
        heading = 0;
      });
    }
  }

  Future<void> checkSensorAvailable() async {
    bool compassAvailable =
        await SensorManager().isSensorAvailable(Sensors.MAGNETIC_FIELD);
    if (compassAvailable != true) {
      setState(() {
        showPop();
      });
    }
  }

  String getDirection() {
    final directions = ['N', 'NE', 'E', 'SE', 'S', 'SW', 'W', 'NW'];
    final index = ((heading! + 22.5) % 360 / 45).floor();
    return directions[index];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: HexColor("#050A0C"),
        appBar: AppBar(
          leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_sharp,
                  color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              }),
          backgroundColor: HexColor("#050A0C"),
          centerTitle: true,
          title: const Text("Compass",
              style: TextStyle(fontWeight: FontWeight.w300)),
          toolbarHeight: 90,
        ),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text("${heading != null ? heading!.abs().ceil() : 0} ⁰ ",
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.bold)),
                Text(heading != 0 ? getDirection() : error,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.bold)),
              ]),
              const SizedBox(height: 50),
              Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Stack(alignment: Alignment.center, children: [
                    Image.asset("assets/images/cadrant.png"),
                    Center(
                        child: Transform.rotate(
                            angle: ((heading ?? 0) * (pi / 180) * -1),
                            child: Image.asset(
                              "assets/images/compass_wheel.png",
                              scale: 1.1,
                              color: HexColor("#e50914"),
                            )))
                  ]))
            ]));
  }

  void showPop() {
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) => AlertDialog(
            title: const Text("Sensor Error",
                style: TextStyle(color: Colors.white)),
            backgroundColor: HexColor("#1f1f1f"),
            icon: const Icon(Icons.warning, size: 40),
            iconColor: Colors.red,
            content: const Text(
                "Sorry, your device doesn't have a compass "
                "sensor. "
                "This means compass won't work on this device."
                " Please try installing this app on an another device.",
                textAlign: TextAlign.start,
                style: TextStyle(color: Colors.white))));
  }
}

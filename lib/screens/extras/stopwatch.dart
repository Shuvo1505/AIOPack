import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const StopwatchScreen());
}

class StopwatchScreen extends StatelessWidget {
  const StopwatchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: StopwatchScreen(),
    );
  }
}

class StopwatchPage extends StatefulWidget {
  const StopwatchPage({super.key});

  @override
  State<StopwatchPage> createState() => _StopwatchPageState();
}

class _StopwatchPageState extends State<StopwatchPage> {
  late bool _isRunning = false;
  int _elapsedMilliseconds = 0;
  late Stopwatch _stopwatch;
  late Timer timer;
  late int savedWatch = 0;
  late bool actionReset = false;

  static const milisecondKey = "ms_key_stopw";

  @override
  void initState() {
    super.initState();
    _stopwatch = Stopwatch();
    timer = Timer.periodic(const Duration(seconds: 1), _updateTime);
    loadGeneratedData();
  }

  void _updateTime(Timer timer) {
    if (_isRunning) {
      setState(() {
        _elapsedMilliseconds = _stopwatch.elapsedMilliseconds;
      });
    }
  }

  void _startStopwatch() {
    setState(() {
      _isRunning = true;
      _stopwatch.start();
    });
  }

  void _pauseStopwatch() {
    setState(() {
      _isRunning = false;
      _stopwatch.stop();
    });
  }

  void _resetStopwatch() {
    setState(() {
      _isRunning = false;
      _stopwatch.stop();
      _stopwatch.reset();
      _elapsedMilliseconds = 0;
    });
  }

  void playLongBeep() {
    final player = AudioPlayer();
    player.play(AssetSource('sounds/long_beep.mp3'));
  }

  void playShortBeep() {
    final player = AudioPlayer();
    player.play(AssetSource('sounds/short_beep.mp3'));
  }

  @override
  void dispose() {
    _stopwatch.stop();
    _stopwatch.reset();
    super.dispose();
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
                if (_elapsedMilliseconds != 0) {
                  setState(() {
                    _elapsedMilliseconds = _stopwatch.elapsedMilliseconds;
                    savedWatch = _elapsedMilliseconds;
                    storeGeneratedData();
                  });
                }
              }),
          backgroundColor: HexColor("#050A0C"),
          centerTitle: true,
          title: const Text("Stopwatch",
              style: TextStyle(fontWeight: FontWeight.w300)),
          toolbarHeight: 90,
        ),
        body: Center(
            child: Container(
                color: HexColor("#050A0C"),
                width: double.infinity,
                height: double.infinity,
                padding: const EdgeInsets.all(30.0),
                child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          const SizedBox(height: 100),
                          Center(
                              child: Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 20),
                                  width: 300,
                                  height: 200,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(18.0),
                                      color: HexColor("#1f1f1f")),
                                  child: Center(
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                        Text(
                                            Duration(
                                                    milliseconds:
                                                        _elapsedMilliseconds)
                                                .toString()
                                                .split('.')
                                                .first,
                                            style: const TextStyle(
                                                fontSize: 90,
                                                color: Colors.white,
                                                fontFamily: 'digital'))
                                      ])))),
                          const SizedBox(height: 40),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                IconButton(
                                    icon: Icon(
                                        _isRunning
                                            ? Icons.pause
                                            : Icons.play_arrow,
                                        color: HexColor("#e50914"),
                                        size: 60),
                                    onPressed: () {
                                      setState(() {
                                        if (_isRunning) {
                                          _pauseStopwatch();
                                          setState(() {
                                            actionReset = true;
                                            _elapsedMilliseconds =
                                                _stopwatch.elapsedMilliseconds;
                                            savedWatch = _elapsedMilliseconds;
                                            storeGeneratedData();
                                            playShortBeep();
                                          });
                                        } else {
                                          _startStopwatch();
                                          setState(() {
                                            actionReset = true;
                                            playShortBeep();
                                          });
                                        }
                                      });
                                    }),
                                const SizedBox(width: 20),
                                Visibility(
                                    visible: actionReset,
                                    child: IconButton(
                                        icon: Icon(
                                          Icons.stop,
                                          color: HexColor("#e50914"),
                                          size: 60,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _elapsedMilliseconds =
                                                _stopwatch.elapsedMilliseconds;
                                            savedWatch = _elapsedMilliseconds;
                                            storeGeneratedData();
                                            actionReset = false;
                                          });
                                          _resetStopwatch();
                                          playLongBeep();
                                        }))
                              ]),
                          const SizedBox(height: 50),
                          Center(
                              child: Column(children: [
                            Text("Latest Record",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: HexColor("#FFA500"),
                                    fontWeight: FontWeight.bold)),
                            const SizedBox(height: 10),
                            Text(
                                Duration(milliseconds: savedWatch)
                                    .toString()
                                    .split('.')
                                    .first,
                                style: const TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                            Visibility(
                                visible: savedWatch != 0 ? true : false,
                                child: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        savedWatch = 0;
                                        storeGeneratedData();
                                      });
                                    },
                                    icon: const Icon(Icons.refresh,
                                        color: Colors.white)))
                          ]))
                        ])))));
  }

  Future<void> loadGeneratedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      savedWatch = prefs.getInt(milisecondKey) ?? 0;
    });
  }

  Future<void> storeGeneratedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(milisecondKey, savedWatch);
  }
}

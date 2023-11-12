import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../screens/health/bmi.dart';

void main() {
  runApp(const SplashScreen());
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AIOPack',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashPage(),
    );
  }
}

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  BuildContext? _context;

  @override
  void initState() {
    super.initState();
    _context = context;
    _loadSplash();
  }

  _loadSplash() async {
    await Future.delayed(const Duration(seconds: 6));

    Navigator.of(_context!).pushReplacement(_createRoute());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            width: double.infinity,
            height: double.infinity,
            color: HexColor("#050A0C"),
            child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Center(
                            child: SizedBox(height: 300),
                          ),
                          Center(
                            child: SizedBox(
                              child: CircleAvatar(
                                radius: 48,
                                backgroundColor: HexColor("#050A0C"),
                                child: const Image(
                                  image:
                                      AssetImage("assets/images/app-icon.png"),
                                  height: 66,
                                  width: 66,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Center(
                              child: DefaultTextStyle(
                                  style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                  child: AnimatedTextKit(animatedTexts: [
                                    WavyAnimatedText('AIOPack',
                                        textAlign: TextAlign.center)
                                  ], isRepeatingAnimation: true)))
                        ])))));
  }

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          const HomePage(title: "BMI Calculator"),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}

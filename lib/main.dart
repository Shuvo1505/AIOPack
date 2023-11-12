import 'package:aiopack/splash/splashscreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const AIOPack());
}

class AIOPack extends StatelessWidget {
  const AIOPack({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashPage(),
      theme: ThemeData(primarySwatch: Colors.deepPurple),
    );
  }
}

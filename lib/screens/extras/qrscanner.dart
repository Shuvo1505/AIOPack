import 'package:aiopack/components/scanner.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const QRScanPage());
}

class QRScanPage extends StatelessWidget {
  const QRScanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Scanner(),
      theme: ThemeData(primarySwatch: Colors.deepPurple),
    );
  }
}

import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const QRScreen());
}

class QRScreen extends StatelessWidget {
  const QRScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: QRGeneratorPage(),
    );
  }
}

class QRGeneratorPage extends StatefulWidget {
  const QRGeneratorPage({super.key});

  @override
  State<QRGeneratorPage> createState() => _QRGeneratorPageState();
}

class _QRGeneratorPageState extends State<QRGeneratorPage> {
  late String _inputText = '';
  late final String _head = "Generated QR Code";
  final TextEditingController _textController = TextEditingController();
  late SharedPreferences? prefs;
  static const String textKey = "text_key_qrgen";
  late final qrKey = GlobalKey();

  notifyError(String message) {
    Fluttertoast.showToast(
        msg: message,
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_SHORT,
        fontSize: 16.0,
        backgroundColor: HexColor("#AF002A"),
        textColor: Colors.white);
  }

  notifyPermission(String message) {
    Fluttertoast.showToast(
        msg: message,
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_SHORT,
        fontSize: 16.0,
        backgroundColor: HexColor("#1f1f1f"),
        textColor: Colors.white);
  }

  notifySuccess(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      behavior: SnackBarBehavior.floating,
    ));
  }

  @override
  void initState() {
    super.initState();
    _textController.addListener(() {
      setState(() {
        _inputText = _textController.value.text.toString();
        prefs?.setString(textKey, _inputText);
      });
    });
    loadGeneratedData();
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
          title: const Text("QR Generator",
              style: TextStyle(fontWeight: FontWeight.w300)),
          toolbarHeight: 90,
        ),
        body: Container(
            height: double.infinity,
            width: double.infinity,
            color: HexColor("#050A0C"),
            padding: const EdgeInsets.all(30.0),
            child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      Container(
                          margin: const EdgeInsets.all(12.0),
                          child: Text(_inputText.isNotEmpty ? _head : "",
                              style: const TextStyle(
                                  fontSize: 24,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold))),
                      const SizedBox(height: 10),
                      _inputText.isNotEmpty
                          ? RepaintBoundary(
                              key: qrKey,
                              child: QrImageView(
                                  data: _inputText,
                                  backgroundColor: Colors.white,
                                  version: QrVersions.auto,
                                  size: 200.0),
                            )
                          : const SizedBox(height: 10),
                      const SizedBox(height: 8),
                      _inputText.isNotEmpty
                          ? IconButton(
                              onPressed: () async {
                                final status =
                                    await Permission.storage.request();
                                if (status.isGranted) {
                                  saveQRCodeImage();
                                }
                                if (status.isDenied) {
                                  notifyPermission(
                                      "Permission required to save QR image.");
                                }
                                if (status.isPermanentlyDenied) {
                                  await openAppSettings();
                                }
                              },
                              icon: Icon(
                                Icons.file_download_outlined,
                                color: HexColor("#e50914"),
                                size: 40,
                              ))
                          : const SizedBox(height: 10),
                      const SizedBox(height: 60),
                      TextField(
                          keyboardType: TextInputType.multiline,
                          textAlign: TextAlign.start,
                          maxLines: 6,
                          cursorColor: Colors.white,
                          autofocus: false,
                          controller: _textController,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1887)
                          ],
                          textInputAction: TextInputAction.newline,
                          onEditingComplete: () {},
                          style: const TextStyle(
                              fontSize: 16.4, color: Colors.white),
                          decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: HexColor("#e50914"), width: 2.0),
                                  borderRadius: BorderRadius.circular(20.0)),
                              hintText: "Type here to generate",
                              hintStyle: const TextStyle(color: Colors.grey),
                              filled: true,
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: HexColor("#e50914"), width: 5.0),
                                  borderRadius: BorderRadius.circular(20.0)),
                              fillColor: HexColor("#1f1f1f"))),
                    ]))));
  }

  Future<void> loadGeneratedData() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      _inputText = prefs?.getString(textKey) ?? "";
      _textController.text = _inputText;
    });
  }

  final globalKey = GlobalKey();

  Future<void> saveQRCodeImage() async {
    RenderRepaintBoundary boundary =
        qrKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage(pixelRatio: 3.0);
    ByteData? byteData = await image.toByteData(
        format: ui.ImageByteFormat.png); // Note the '?' here
    if (byteData != null) {
      Uint8List uint8list = byteData.buffer.asUint8List();

      final directory = await getTemporaryDirectory();
      final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
      final imagePath = '${directory.path}/qr_code_aiopack_$timestamp.png';
      File imageFile = File(imagePath);
      await imageFile.writeAsBytes(uint8list);

      final success = await GallerySaver.saveImage(imageFile.path);
      if (success == true) {
        notifySuccess("Saved to gallery");
      } else {
        notifyError("Storage permission required");
      }
    } else {
      notifyError("Storage permission required");
    }
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}

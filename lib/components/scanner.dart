import 'dart:async';

import 'package:aiopack/components/qrscanneroverlay.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:scan/scan.dart';
import 'package:velocity_x/velocity_x.dart';

class Scanner extends StatefulWidget {
  const Scanner({Key? key}) : super(key: key);

  @override
  State<Scanner> createState() => _ScannerState();
}

class _ScannerState extends State<Scanner> {
  MobileScannerController cameraController = MobileScannerController();
  late bool scrolling = false;
  late bool loading = false;
  late String? qrcode = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  notifyPermission(String message) {
    Fluttertoast.showToast(
        msg: message,
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_SHORT,
        fontSize: 16.0,
        backgroundColor: HexColor("#AF002A"),
        textColor: Colors.white);
  }

  notifySuccess(String message) {
    Fluttertoast.showToast(
        msg: message,
        gravity: ToastGravity.TOP,
        toastLength: Toast.LENGTH_SHORT,
        fontSize: 16.0,
        backgroundColor: Colors.green,
        textColor: Colors.white);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      Visibility(
        visible: true,
        child: MobileScanner(
          controller: MobileScannerController(
              detectionSpeed: DetectionSpeed.noDuplicates),
          onDetect: (capture) {
            final List<Barcode> barcodes = capture.barcodes;
            for (final barcode in barcodes) {
              qrcode = barcode.rawValue;
            }
            showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (BuildContext context) {
                  return SizedBox(
                    height: context.screenHeight,
                    width: context.screenWidth,
                    child: Card(
                      elevation: 0,
                      color: HexColor("#1f1f1f"),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                          side: BorderSide.none),
                      child: RawScrollbar(
                        thumbColor: HexColor("#ff4f00"),
                        thumbVisibility: scrolling == true ? true : false,
                        thickness: 4,
                        radius: const Radius.circular(8),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: InkWell(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () {
                              setState(() {
                                scrolling = true;
                              });
                            },
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const SizedBox(height: 40),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(
                                            right: 10, top: 10),
                                        child: IconButton(
                                          icon: const Icon(Icons.close_rounded),
                                          color: Colors.white,
                                          onPressed: () {
                                            setState(() {
                                              Navigator.pop(context);
                                            });
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Text("Scanned Result",
                                      style: TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white)),
                                  const SizedBox(height: 16.0),
                                  Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: SizedBox(
                                        width: context.screenWidth,
                                        child: Text(
                                          qrcode!,
                                          textAlign: TextAlign.start,
                                          style: const TextStyle(
                                              fontSize: 16.0,
                                              color: Colors.white),
                                        )),
                                  ),
                                  const SizedBox(height: 30),
                                  Container(
                                    margin: const EdgeInsets.only(bottom: 30),
                                    child: SizedBox(
                                      width: context.screenWidth / 2,
                                      height: 40,
                                      child: ElevatedButton(
                                          onPressed: () {
                                            Clipboard.setData(
                                                ClipboardData(text: qrcode!));
                                            notifySuccess("✓ Copied");
                                          },
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  HexColor("#e50914"),
                                              shape:
                                                  const RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  20.0)))),
                                          child: const Text("Copy",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16))),
                                    ),
                                  ),
                                ]),
                          ),
                        ),
                      ),
                    ),
                  );
                });
          },
        ),
      ),
      Visibility(
          visible: true,
          child: QRScannerOverlay(
              overlayColour: HexColor("#050A0C").withOpacity(0.5))),
      Container(
        margin: const EdgeInsets.only(bottom: 70),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Visibility(
                visible: true,
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.black38),
                  child: IconButton(
                      color: Colors.white,
                      iconSize: 30,
                      icon: const Icon(Icons.mobile_friendly),
                      onPressed: () {
                        showPop();
                      }),
                ),
              ),
              const SizedBox(width: 50),
              Visibility(
                  visible: true,
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.black38),
                    child: IconButton(
                        onPressed: () {
                          setState(() {
                            loading = true;
                          });
                          _pickImageFromGallery();
                        },
                        color: Colors.white,
                        iconSize: 30,
                        icon: const Icon(Icons.image)),
                  ))
            ],
          ),
        ),
      ),
      Container(
        margin: const EdgeInsets.only(top: 70),
        child: Align(
          alignment: Alignment.topCenter,
          child: Container(
            width: 250,
            height: 60,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.black38),
            child: const Center(
              child: Text(
                "Find a QR code",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 20),
              ),
            ),
          ),
        ),
      ),
      Visibility(
        visible: loading == true ? true : false,
        child: Align(
          alignment: Alignment.center,
          child: Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.black38),
            child: const Column(
              children: [
                SizedBox(height: 20),
                Text(
                  "Analyzing",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
                SizedBox(height: 58),
                SizedBox(
                  width: 100,
                  child: LinearProgressIndicator(
                    color: Colors.red,
                    backgroundColor: Colors.transparent,
                  ),
                ),
              ],
            ),
          ),
        ),
      )
    ]));
  }

  void showPop() {
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) => AlertDialog(
            backgroundColor: HexColor("#1f1f1f"),
            title: const Text("Scanning Guide",
                style: TextStyle(color: Colors.white)),
            content: const Text(
                "This system will not scan duplicate QR code again and again. "
                "If scanner is not scanning a QR code. This means"
                " that particular QR was scanned by this scanner. You should try"
                " to scan a different QR code.",
                style: TextStyle(color: Colors.white))));
  }

  Future<void> _pickImageFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final String? result = await Scan.parse(pickedFile.path);

      if (result != null && context.mounted) {
        setState(() {
          loading = false;
        });
        showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (BuildContext context) {
              return SizedBox(
                height: context.screenHeight,
                width: context.screenWidth,
                child: Card(
                  elevation: 0,
                  color: HexColor("#1f1f1f"),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: BorderSide.none),
                  child: RawScrollbar(
                    thumbColor: HexColor("#ff4f00"),
                    thumbVisibility: scrolling == true ? true : false,
                    thickness: 4,
                    radius: const Radius.circular(8),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () {
                          setState(() {
                            scrolling = true;
                          });
                        },
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(height: 40),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(
                                        right: 10, top: 10),
                                    child: IconButton(
                                      icon: const Icon(Icons.close_rounded),
                                      color: Colors.white,
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              const Text("Scanned Result",
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                              const SizedBox(height: 16.0),
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: SizedBox(
                                    width: context.screenWidth,
                                    child: Text(
                                      result,
                                      textAlign: TextAlign.start,
                                      style: const TextStyle(
                                          fontSize: 16.0, color: Colors.white),
                                    )),
                              ),
                              const SizedBox(height: 30),
                              Container(
                                margin: const EdgeInsets.only(bottom: 30),
                                child: SizedBox(
                                  width: context.screenWidth / 2,
                                  height: 40,
                                  child: ElevatedButton(
                                      onPressed: () {
                                        Clipboard.setData(
                                            ClipboardData(text: result));
                                        notifySuccess("✓ Copied");
                                      },
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: HexColor("#e50914"),
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20.0)))),
                                      child: const Text("Copy",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16))),
                                ),
                              ),
                            ]),
                      ),
                    ),
                  ),
                ),
              );
            });
      } else {
        setState(() {
          loading = false;
        });
        notifyPermission("No QR code found");
      }
    } else {
      setState(() {
        loading = false;
      });
      notifyPermission("Aborted image selection");
    }
  }
}

import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const CryptoScreen());
}

class CryptoScreen extends StatelessWidget {
  const CryptoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AIOPack',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const CryptoPage(),
    );
  }
}

class CryptoPage extends StatefulWidget {
  const CryptoPage({super.key});

  @override
  State<CryptoPage> createState() => _CryptoPageState();
}

class _CryptoPageState extends State<CryptoPage> {
  TextEditingController unitController = TextEditingController();
  TextEditingController pkController = TextEditingController();

  late String selectedValue = "MD5";

  List<String> dropdownItems = ["MD5", "SHA1", "SHA512", "SHA256"];

  late String encValue = "";
  late String msgValue = "";
  late String algoValue = "";
  late bool isCopyIcon = true;
  late bool isDivider = false;
  late bool isKeyHead = false;
  late bool isKeyData = false;

  static const String encKey = "enc_key_crypt";
  static const String msgKey = "msg_key_crypt";
  static const String algoKey = "algo_key_crypt";

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
          title: const Text("Hash Generator",
              style: TextStyle(fontWeight: FontWeight.w300)),
          toolbarHeight: 90,
        ),
        body: Container(
            width: double.infinity,
            height: double.infinity,
            color: HexColor("#050A0C"),
            child: SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                  margin: const EdgeInsets.all(12.0),
                                  child: const Text("Enter Your Message / text",
                                      style: TextStyle(
                                          fontSize: 24,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold))),
                            ],
                          ),
                          TextField(
                              keyboardType: TextInputType.multiline,
                              textAlign: TextAlign.center,
                              controller: unitController,
                              maxLines: 4,
                              cursorColor: Colors.white,
                              autofocus: false,
                              textInputAction: TextInputAction.newline,
                              onEditingComplete: () {},
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
                          const SizedBox(height: 16),
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
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12),
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
                                          borderRadius:
                                              BorderRadius.circular(18.0),
                                          underline: Container(),
                                          icon: const Icon(
                                              Icons
                                                  .arrow_drop_down_circle_outlined,
                                              color: Colors.white),
                                        ),
                                      )))),
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
                                          FocusScope.of(context).unfocus();
                                        } else {
                                          encryptedData(unitController
                                              .value.text
                                              .toString());
                                          FocusScope.of(context).unfocus();
                                          storeGeneratedData();
                                        }
                                      },
                                      child: const Text("Generate",
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
                                          encValue = "";
                                          msgValue = "";
                                          FocusScope.of(context).unfocus();
                                          selectedValue = dropdownItems[0];
                                          unitController.clear();
                                          isCopyIcon = false;
                                          isDivider = false;
                                          isKeyData = false;
                                          isKeyHead = false;
                                          storeGeneratedData();
                                        });
                                      },
                                      child: const Text("Reset",
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white))),
                                )
                              ]),
                          Center(
                              child: Column(children: [
                            const SizedBox(height: 60),
                            SizedBox(
                                width: 300,
                                child: Center(
                                    child: SingleChildScrollView(
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                      Text(
                                          encValue.isEmpty
                                              ? ""
                                              : "Original Message / text       ",
                                          style: TextStyle(
                                              color: HexColor("#FFA500"),
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold)),
                                      encValue.isEmpty
                                          ? Container()
                                          : Visibility(
                                              visible: isCopyIcon,
                                              child: IconButton(
                                                  icon: encValue.isEmpty
                                                      ? Container()
                                                      : const Icon(
                                                          Icons.copy_outlined),
                                                  color: Colors.white,
                                                  iconSize: 20,
                                                  onPressed: () {
                                                    copyMessageContent(
                                                        msgValue);
                                                  }))
                                    ])))),
                            const SizedBox(height: 16),
                            SizedBox(
                              width: 254,
                              child: Text(msgValue,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.start),
                            ),
                            const SizedBox(height: 10),
                            Visibility(
                              visible: isDivider,
                              child: const Divider(
                                thickness: 2,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                                width: 340,
                                child: Center(
                                    child: SingleChildScrollView(
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                      Text(encValue.isEmpty ? "" : algoValue,
                                          style: TextStyle(
                                              color: HexColor("#FFA500"),
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold)),
                                      encValue.isEmpty
                                          ? Container()
                                          : Visibility(
                                              visible: isCopyIcon,
                                              child: IconButton(
                                                  icon: encValue.isEmpty
                                                      ? Container()
                                                      : const Icon(
                                                          Icons.copy_outlined),
                                                  color: Colors.white,
                                                  iconSize: 20,
                                                  onPressed: () {
                                                    copyEncryptedContent(
                                                        encValue);
                                                  }))
                                    ])))),
                            Visibility(
                              visible: encValue.isEmpty ? true : false,
                              child: const Text("No data available",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 20,
                                  )),
                            ),
                            const SizedBox(height: 16),
                            SizedBox(
                              width: 268,
                              child: Text(encValue,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.start),
                            ),
                            const SizedBox(height: 10)
                          ]))
                        ])))));
  }

  void copyEncryptedContent(String value) {
    Clipboard.setData(ClipboardData(text: value));
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Copied result to clipboard"),
        behavior: SnackBarBehavior.floating));
  }

  void copyMessageContent(String value) {
    Clipboard.setData(ClipboardData(text: value));
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Copied message to clipboard"),
        behavior: SnackBarBehavior.floating));
  }

  void encryptedData(String value) {
    if (selectedValue == "MD5") {
      if (value.isNotEmpty) {
        var bytes = utf8.encode(value);
        var md5Hash = md5.convert(bytes);
        String res = md5Hash.toString();
        setState(() {
          isCopyIcon = true;
          isDivider = true;
          encValue = res;
          msgValue = unitController.value.text.toString();
          algoValue = "Generated Hash (MD5)";
        });
      }
    }
    if (selectedValue == "SHA1") {
      if (value.isNotEmpty) {
        var bytes = utf8.encode(value);
        var sha1Hash = sha1.convert(bytes);
        String res = sha1Hash.toString();
        setState(() {
          isCopyIcon = true;
          isDivider = true;
          encValue = res;
          msgValue = unitController.value.text.toString();
          algoValue = "Generated Hash (SHA1)";
        });
      }
    }
    if (selectedValue == "SHA512") {
      if (value.isNotEmpty) {
        var bytes = utf8.encode(value);
        var sha512Hash = sha512.convert(bytes);
        String res = sha512Hash.toString();
        setState(() {
          isCopyIcon = true;
          isDivider = true;
          encValue = res;
          msgValue = unitController.value.text.toString();
          algoValue = "Generated Hash (SHA512)";
        });
      }
    }
    if (selectedValue == "SHA256") {
      if (value.isNotEmpty) {
        var bytes = utf8.encode(value);
        var sha256Hash = sha256.convert(bytes);
        String res = sha256Hash.toString();
        setState(() {
          isCopyIcon = true;
          isDivider = true;
          encValue = res;
          msgValue = unitController.value.text.toString();
          algoValue = "Generated Hash (SHA256)";
        });
      }
    }
  }

  Future<void> loadGeneratedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      encValue = prefs.getString(encKey) ?? "";
      msgValue = prefs.getString(msgKey) ?? "";
      algoValue = prefs.getString(algoKey) ?? "";
    });
  }

  Future<void> storeGeneratedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(encKey, encValue);
    prefs.setString(msgKey, msgValue);
    prefs.setString(algoKey, algoValue);
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

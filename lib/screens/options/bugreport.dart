import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';

void main() {
  runApp(const BugScreen());
}

class BugScreen extends StatelessWidget {
  const BugScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AIOPack',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const BugPage(title: 'Bug Report'),
    );
  }
}

class BugPage extends StatefulWidget {
  const BugPage({super.key, required this.title});

  final String title;

  @override
  State<BugPage> createState() => _BugPageState();
}

class _BugPageState extends State<BugPage> {
  TextEditingController errReport = TextEditingController();

  static const String appName = "AIOPack";

  notifyError(String message) {
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
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_SHORT,
        fontSize: 16.0,
        backgroundColor: Colors.green,
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
                scrollDirection: Axis.vertical,
                child: Padding(
                    padding: const EdgeInsets.all(26.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Center(
                            child: SizedBox(height: 10),
                          ),
                          Center(
                              child: SizedBox(
                                  height: 120,
                                  width: 120,
                                  child: Image.asset("assets/images/bug.png"))),
                          const Center(
                            child: SizedBox(height: 20),
                          ),
                          const Center(
                              child: SizedBox(
                            width: 260,
                            child: Text(
                              "Please do not include any personal or unnecessary information in your problem. Once you submit your issue, The developer will release the patch/fix as soon as possible.",
                              textAlign: TextAlign.start,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          )),
                          const Center(
                            child: SizedBox(height: 20),
                          ),
                          Center(
                              child: SizedBox(
                            width: 400,
                            child: TextFormField(
                                keyboardType: TextInputType.multiline,
                                textAlign: TextAlign.start,
                                maxLines: 6,
                                controller: errReport,
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
                                    hintText: "Write your problem here",
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
                          )),
                          const Center(
                            child: SizedBox(height: 28),
                          ),
                          Center(
                              child: SizedBox(
                            width: 180,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: HexColor("#e50914"),
                                    shape: ContinuousRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0))),
                                onPressed: () async {
                                  if (errReport.value.text == "") {
                                    notifyError(
                                        "Please write your problem first");
                                  } else {
                                    prepareToSend(
                                        errReport.value.text.toString());
                                  }
                                },
                                child: const Text("SUBMIT",
                                    style: TextStyle(
                                        fontSize: 16.4, color: Colors.white))),
                          ))
                        ])))));
  }

  Future<void> prepareToSend(String msgbody) async {
    final Email email = Email(
        body: msgbody,
        subject: 'Bug Report [$appName]',
        recipients: ['developbyheart33@gmail.com']);
    try {
      await FlutterEmailSender.send(email);
      errReport.clear();
    } on Exception {
      notifyError("No email client was found");
    }
  }

  @override
  void dispose() {
    errReport.dispose();
    super.dispose();
  }
}

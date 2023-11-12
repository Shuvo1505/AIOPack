import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';

void main() {
  runApp(const FeedbackScreen());
}

class FeedbackScreen extends StatelessWidget {
  const FeedbackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AIOPack',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const FeedbackPage(title: 'Feedback Section'),
    );
  }
}

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key, required this.title});

  final String title;

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  late double userRating = 0;
  late String emotionState = "";
  late String emotionTalk = "";
  TextEditingController feedReport = TextEditingController();

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
            toolbarHeight: 90),
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
                                  height: 126,
                                  width: 126,
                                  child: Image.asset(
                                      "assets/images/feedback.png"))),
                          const Center(
                            child: SizedBox(height: 40),
                          ),
                          const Center(
                              child: Text("Please rate your experience",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold))),
                          const Center(child: SizedBox(height: 20)),
                          Center(
                              child: RatingBar(
                                  initialRating: userRating,
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemSize: 40,
                                  ratingWidget: RatingWidget(
                                    full: Icon(Icons.star,
                                        color: HexColor("#FFA500")),
                                    half: Icon(Icons.star_half,
                                        color: HexColor("#FFA500")),
                                    empty: Icon(Icons.star_border,
                                        color: HexColor("#FFA500")),
                                  ),
                                  onRatingUpdate: (rating) {
                                    setState(() {
                                      userRating = rating;
                                      predictEmotion(userRating);
                                    });
                                  })),
                          const Center(
                            child: SizedBox(height: 20),
                          ),
                          Center(
                              child: SizedBox(
                                  width: 50,
                                  height: 50,
                                  child: CircleAvatar(
                                    backgroundImage: AssetImage(emotionState),
                                    backgroundColor: HexColor("#050A0C"),
                                  ))),
                          const Center(
                            child: SizedBox(height: 20),
                          ),
                          Center(
                              child: Text(emotionTalk,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ))),
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
                                maxLength: 200,
                                controller: feedReport,
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
                                    hintText: "Additional Comments",
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
                            child: SizedBox(height: 10),
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
                                onPressed: () {
                                  if (feedReport.value.text == "") {
                                    if (userRating != 0.0) {
                                      String comments = "N/A";
                                      prepareToSend(
                                          userRating, emotionTalk, comments);
                                    } else {
                                      notifyError("Please rate first");
                                    }
                                  } else {
                                    String comments =
                                        feedReport.value.text.toString();
                                    prepareToSend(
                                        userRating, emotionTalk, comments);
                                  }
                                },
                                child: const Text("SUBMIT",
                                    style: TextStyle(
                                        fontSize: 16.4, color: Colors.white))),
                          ))
                        ])))));
  }

  void predictEmotion(double rating) {
    if (rating >= 1.0 && rating <= 1.5) {
      emotionState = "assets/images/worst.png";
      emotionTalk = "Worst";
    } else if (rating >= 2.0 && rating <= 2.5) {
      emotionState = "assets/images/bad.png";
      emotionTalk = "Bad";
    } else if (rating >= 3.0 && rating <= 3.5) {
      emotionState = "assets/images/fair.png";
      emotionTalk = "Fair";
    } else if (rating >= 4.0 && rating <= 4.5) {
      emotionState = "assets/images/good.png";
      emotionTalk = "Good";
    } else if (rating >= 5.0) {
      emotionState = "assets/images/excellent.png";
      emotionTalk = "Excellent";
    }
  }

  Future<void> prepareToSend(
      double rating, String statement, String comments) async {
    rating = userRating;
    statement = emotionTalk;
    final Email email = Email(
        body: "Rating: $rating ($statement) \n\n "
            "Additional Comments: $comments",
        subject: 'Feedback Report [$appName]',
        recipients: ['developbyheart33@gmail.com']);
    try {
      await FlutterEmailSender.send(email);
      feedReport.clear();
    } on Exception {
      notifyError("No email client was found");
    }
  }
}

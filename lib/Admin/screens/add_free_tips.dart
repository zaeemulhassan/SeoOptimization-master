import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:seooptimization/Admin/controllers/http_controllers.dart';
import 'package:seooptimization/Admin/widgets/circular_progress.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../snack_bar.dart';

const colorizeColors = [
  Colors.black,
  Colors.green,
  Colors.lightGreen,
  Colors.lightGreenAccent,
  Colors.greenAccent,
];

const colorizeTextStyle = TextStyle(
  fontSize: 30.0,
  fontFamily: 'Montserrat',
);

class AddTipsScreen extends StatelessWidget {
  final String text;
  AddTipsScreen({Key key, @required this.text}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return _AddTipsScreen();
  }
}

class _AddTipsScreen extends StatefulWidget {
  _AddTipsScreen({Key key}) : super(key: key);
  @override
  _AddTipsScreenState createState() => _AddTipsScreenState();
}

class _AddTipsScreenState extends State<_AddTipsScreen> {
  String selectedItem;
  double _registerBtnSize = 315;
  double _btnBorder = 4;
  bool _isLoading = false;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextStyle style =
      TextStyle(fontFamily: 'Montserrat', fontSize: 20.0, color: Colors.black);
  var webView = Container();
  ProgressDialog pr;
  final GlobalKey<ScaffoldState> mScaffoldState =
      new GlobalKey<ScaffoldState>();

  FocusNode _textFocus = new FocusNode();
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    getProgressBarSetUp();
  }

  @override
  Widget build(BuildContext context) {
    final textCard = Container(
      child: Center(
        child: AnimatedTextKit(
          animatedTexts: [
            TypewriterAnimatedText(
              'Free Tips',
              textStyle: TextStyle(
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold,
                  color: hexToColor("#00a859")),
            ),
            // TyperAnimatedText(
            //   'Add Tips',
            //   textStyle: TextStyle(fontSize: 32.0, fontFamily: 'Canterbury'),
            // ),
          ],
          isRepeatingAnimation: true,
          pause: const Duration(milliseconds: 1000),
          repeatForever: true,
        ),
      ),
    );

    final titleCard = Card(
      elevation: 3,
      color: hexToColor("#f7fffb"),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6.0),
      ),
      borderOnForeground: true,
      margin: EdgeInsets.only(right: 24, left: 24),
      child: Column(
        children: <Widget>[
          Container(
              margin: EdgeInsets.only(top: 6, left: 8, right: 6),
              child: TextField(
                textAlign: TextAlign.left,
                controller: titleController,
                decoration: new InputDecoration(
                    icon: Icon(
                      Icons.title,
                      size: 40,
                      color: hexToColor("#00a859"),
                    ),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    contentPadding:
                        EdgeInsets.only(right: 8, bottom: 4, top: 10),
                    hintText: "Title"),
              ))
        ],
      ),
    );
    final descrriptionCard = Card(
      elevation: 3,
      color: hexToColor("#f7fffb"),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6.0),
      ),
      borderOnForeground: true,
      margin: EdgeInsets.only(right: 24, left: 24),
      child: Column(
        children: <Widget>[
          Container(
              margin: EdgeInsets.only(top: 6, left: 8, right: 6),
              child: TextField(
                keyboardType: TextInputType.multiline,
                textAlign: TextAlign.left,
                controller: descriptionController,
                maxLines: 10,
                decoration: new InputDecoration(
                    icon: Icon(
                      Icons.description,
                      size: 40,
                      color: hexToColor("#00a859"),
                    ),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    contentPadding:
                        EdgeInsets.only(right: 8, bottom: 4, top: 10),
                    hintText: "Description"),
              ))
        ],
      ),
    );

    return Scaffold(
      key: mScaffoldState,
      backgroundColor: hexToColor("#f7fffb"),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 30,
            ),
            textCard,
            SizedBox(
              height: 30,
            ),
            titleCard,
            SizedBox(
              height: 16,
            ),
            descrriptionCard,
            SizedBox(
              height: 50,
            ),
            AnimatedContainer(
              duration: Duration(milliseconds: 500),
              child: GestureDetector(
                onTap: () {
                  _addTipsTap();
                },
                child: Container(
                  margin: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                  width: MediaQuery.of(context).size.width,

                  // color: hexToColor("#00a859"),
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: hexToColor("#00a859"),
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  child: _isLoading
                      ? CircularProgress()
                      : Text(
                          "ADD TIPS",
                          textAlign: TextAlign.center,
                          style: style.copyWith(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }

  _addTipsTap() {
    if (titleController.text.isNotEmpty &&
        descriptionController.text.isNotEmpty) {
      setState(() {
        _isLoading = true;
        _registerBtnSize = 80;
        _btnBorder = 20;
      });
      HttpControllers()
          .addTips(
              title: titleController.text,
              description: descriptionController.text)
          .then((response) {
        setState(() {
          _isLoading = false;
          _registerBtnSize = 315;
          _btnBorder = 4;
          print("all $response");
        });
        var message;
        var status;
        String msg = 'Unpredicted Error';
        for (int i = 0; i < response.length; i++) {
          status = response[i]["response"];
          message = response[i]["msg"];
        }
        if (status == '200') {
          var value = message.substring(29, 30);
          titleController.text = '';
          descriptionController.text = '';
          print("id $value");
          saveTipsId(value);
          msg = "Tips has been added";
        } else if (response == '22') {
          // Database Error
          msg = 'Server is not responding!';
        } else if (response == '33') {
          // Unpredicted Error
          msg = 'Unpredicted Error';
        } else {
          // Random Error
          msg = 'Unpredicted Error';
        }
        Sbar().showSnackBar(msg, mScaffoldState);
      });
    } else {
      Sbar().showSnackBar('Fill Required Fields', mScaffoldState);
    }
  }

  Future saveTipsId(var id) async {
    SharedPreferences userTips = await SharedPreferences.getInstance();
    userTips.setString("TipsId", id);
  }

  Color hexToColor(String code) {
    return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }

  File _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _image = File(pickedFile.path);

      // uploadImage(pickedFile.path.toString());
    });
  }

  void getProgressBarSetUp() {
    pr = ProgressDialog(
      context,
      isDismissible: false,
    );
    pr.style(
        message: ' Uploading...',
        borderRadius: 4.0,
        backgroundColor: Colors.white,
        progressWidget: Padding(
          padding: EdgeInsets.all(8.0),
          child: CircularProgressIndicator(),
        ),
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        progress: 0.0,
        maxProgress: 100.0,
        messageTextStyle: TextStyle(
            color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600));
  }
}

BoxDecoration myBoxDecoration() {
  return BoxDecoration(
    border: Border.all(width: 1.0, color: Colors.grey),
    borderRadius:
        BorderRadius.all(Radius.circular(5.0) //         <--- border radius here
            ),
  );
}

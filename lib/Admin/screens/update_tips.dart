import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:seooptimization/Admin/controllers/http_controllers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:seooptimization/Admin/widgets/circular_progress.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../snack_bar.dart';

class UpdateTipsScreen extends StatelessWidget {
  final String id;
  final String title;
  final String description;
  UpdateTipsScreen(
      {Key key,
      @required this.id,
      @required this.title,
      @required this.description})
      : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return _UpdateTipsScreen(
      id: id,
      title: title,
      description: description,
    );
  }
}

class _UpdateTipsScreen extends StatefulWidget {
  final String id;
  final String title;
  final String description;
  _UpdateTipsScreen(
      {Key key,
      @required this.id,
      @required this.title,
      @required this.description})
      : super(key: key);
  @override
  _UpdateTipsScreenState createState() => _UpdateTipsScreenState();
}

class _UpdateTipsScreenState extends State<_UpdateTipsScreen> {
  String selectedItem;

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final GlobalKey<ScaffoldState> mScaffoldState =
      new GlobalKey<ScaffoldState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  var webView = Container();
  ProgressDialog pr;
  double _registerBtnSize = 315;
  double _btnBorder = 4;
  bool _isLoading = false;

  FocusNode _textFocus = new FocusNode();
  @override
  void initState() {
    // TODO: implement initState
    titleController.text = widget.title;
    descriptionController.text = widget.description;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final headerbar = Container(
        height: 80,
        color: hexToColor("#f7fffb"),
        margin: EdgeInsets.only(top: 28.0),
        child: Card(
          color: hexToColor("#f7fffb"),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          elevation: 8.0,
          child: Stack(
            children: <Widget>[
              //padding: EdgeInsets.only(top:20.0, right: 8.0),

              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  margin: EdgeInsets.only(top: 20.0, left: 8.0),
                  child: Row(
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: hexToColor("#00a859"),
                        ),
                      ),
                      SizedBox(
                        width: 1,
                      ),
                      Text(
                        "Update Tips",
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.w800),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));

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
              height: 28,
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
                  _updateTipsTap();
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
                          "UPDATE TIPS",
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

  _updateTipsTap() {
    print("id ${widget.id}");
    if (titleController.text.isNotEmpty &&
        descriptionController.text.isNotEmpty) {
      setState(() {
        _isLoading = true;
        _registerBtnSize = 80;
        _btnBorder = 20;
      });
      HttpControllers()
          .updateTips(
              id: widget.id,
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
          titleController.text = '';
          descriptionController.text = '';
          showToast('Tips updated successfully',
              context: this.context,
              backgroundColor: Colors.black,
              animation: StyledToastAnimation.slideFromBottom,
              reverseAnimation: StyledToastAnimation.slideToBottom,
              startOffset: Offset(0.0, 3.0),
              reverseEndOffset: Offset(0.0, 3.0),
              position: StyledToastPosition.bottom,
              duration: Duration(seconds: 4),
              //Animation duration   animDuration * 2 <= duration
              animDuration: Duration(seconds: 1),
              curve: Curves.elasticOut,
              reverseCurve: Curves.fastOutSlowIn);
          Navigator.pushNamedAndRemoveUntil(
              this.context, '/', ModalRoute.withName('/'));
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

  Future<String> getIdPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("UserId");
  }

  Future clearPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("UserId");
    prefs.remove("isLoggedIn");
    prefs.remove("address");
    prefs.remove("email");
    prefs.remove("password");
    prefs.remove("first_name");
    prefs.remove("last_name");
    prefs.clear();
  }

  Color hexToColor(String code) {
    return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
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

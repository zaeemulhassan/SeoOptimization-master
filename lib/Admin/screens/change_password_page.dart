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
import 'SplashScreen.dart';

class ChangePasswordScreen extends StatelessWidget {
  final String text;
  ChangePasswordScreen({Key key, @required this.text}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return _ChangePasswordScreen();
  }
}

class _ChangePasswordScreen extends StatefulWidget {
  _ChangePasswordScreen({Key key}) : super(key: key);
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<_ChangePasswordScreen> {
  String selectedItem;

  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final GlobalKey<ScaffoldState> mScaffoldState =
      new GlobalKey<ScaffoldState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  var webView = Container();
  ProgressDialog pr;
  double _registerBtnSize = 315;
  double _btnBorder = 4;
  bool _isLoading = false;
  bool _obscureText = true;
  bool _obscureText2 = true;
  bool _obscureText3 = true;
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _toggle2() {
    setState(() {
      _obscureText2 = !_obscureText2;
    });
  }
  void _toggle3() {
    setState(() {
      _obscureText3 = !_obscureText3;
    });
  }
  FocusNode _textFocus = new FocusNode();
  @override
  void initState() {
    // TODO: implement initState

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
                        "Chnage Password",
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

    final oldPasswordCard = Card(
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
                obscureText: _obscureText,
                textAlign: TextAlign.left,
                controller: oldPasswordController,
                decoration: new InputDecoration(
                    icon: Icon(
                      Icons.lock_outline_sharp,
                      size: 40,
                      color: hexToColor("#00a859"),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.remove_red_eye,
                        color: hexToColor("#eccd00"),
                      ),
                      onPressed: _toggle,
                    ),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    contentPadding:
                    EdgeInsets.only(right: 8, bottom: 4, top: 10),
                    hintText: "Old Password"),
              ))
        ],
      ),
    );
    final newPasswordCard = Card(
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
                obscureText: _obscureText2,
                textAlign: TextAlign.left,
                controller: newPasswordController,
                decoration: new InputDecoration(
                    icon: Icon(
                      Icons.lock,
                      size: 40,
                      color: hexToColor("#00a859"),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.remove_red_eye,
                        color: hexToColor("#eccd00"),
                      ),
                      onPressed: _toggle2,
                    ),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    contentPadding:
                    EdgeInsets.only(right: 8, bottom: 4, top: 10),
                    hintText: "New Password"),
              ))
        ],
      ),
    );
    final confirmPasswordCard = Card(
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
                obscureText: _obscureText3,
                controller: confirmPasswordController,
                decoration: new InputDecoration(
                    icon: Icon(
                      Icons.lock_outline,
                      size: 40,
                      color: hexToColor("#00a859"),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.remove_red_eye,
                        color: hexToColor("#eccd00"),
                      ),
                      onPressed: _toggle3,
                    ),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    contentPadding:
                    EdgeInsets.only(right: 8, bottom: 4, top: 10),
                    hintText: "Confirm Password"),
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
            headerbar,
            SizedBox(
              height: 100,
            ),
            oldPasswordCard,
            SizedBox(
              height: 16,
            ),
            newPasswordCard,
            SizedBox(
              height: 16,
            ),
            confirmPasswordCard,
            SizedBox(
              height: 50,
            ),
            AnimatedContainer(
              duration: Duration(milliseconds: 500),
              child: GestureDetector(
                onTap: () {
                  if (newPasswordController.text.length <= 7) {
                    Sbar().showSnackBar(
                        "New password should not be less than 8 character",
                        mScaffoldState);
                  }
                  else if (newPasswordController.text != confirmPasswordController.text) {
                    Sbar().showSnackBar(
                        "Both password should be same", mScaffoldState);
                  }
                  else if (newPasswordController.text == oldPasswordController.text) {
                    Sbar().showSnackBar(
                        "New and old password should not be same", mScaffoldState);
                  }
                  else {
                    _updateTap();
                  }
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
                          "CHANGE PASSWORD",
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

  _updateTap() async {
    if (oldPasswordController.text.isNotEmpty &&
        newPasswordController.text.isNotEmpty) {
      setState(() {
        _isLoading = true;
        _registerBtnSize = 80;
        _btnBorder = 20;
      });
      await getIdPreference().then((userId) async {
        HttpControllers()
            .updatePassword(
                oldPassword: oldPasswordController.text,
                newPassword: newPasswordController.text,
                id: userId)
            .then((response) {
          setState(() {
            _isLoading = false;
            _registerBtnSize = 315;
            _btnBorder = 4;
          });
          String msg = 'Unpredicted Error';
          var message;
          var status;
          for (int i = 0; i < response.length; i++) {
            status = response[i]["response"];
            message = response[i]["msg"];
            if (status == '200') {
              if (message == "Old Password is Incorrect") {
                msg = "$message";
              } else {
                setState(() async {
                  await clearPreference();
                  showToast('Password changed Successfully! Please login again',
                      context: this.context,
                      backgroundColor: Colors.grey,
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

                  Navigator.pushReplacement(this.context,
                      MaterialPageRoute(builder: (context) => SplashScreen()));
                });
              }
            } else if (response == '22') {
              // Database Error
              msg = 'Server is not responding!';
            } else if (response == '409') {
              // Unpredicted Error
              msg = 'You have entered the Wrong Current Password';
            } else {
              // Random Error
              msg = 'Unpredicted Error';
            }
            Sbar().showSnackBar(msg, mScaffoldState);
          }
        });
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

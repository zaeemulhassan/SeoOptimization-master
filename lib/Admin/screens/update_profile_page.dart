import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:seooptimization/Admin/controllers/http_controllers.dart';
import 'package:seooptimization/Admin/widgets/circular_progress.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:progress_dialog/progress_dialog.dart';

import '../../snack_bar.dart';
import 'home_page.dart';

class ProfileUpdateScreen extends StatelessWidget {
  final String fName;
  final String lName;
  final String email;
  final String address;
  final String password;
  final String userId;

  ProfileUpdateScreen(
      {Key key,
      @required this.fName,
      @required this.lName,
      @required this.email,
      @required this.address,
      @required this.password,
      @required this.userId})
      : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return _ProfileUpdateScreen(
        address: address,
        email: email,
        fName: fName,
        lName: lName,
        password: password,
        userId: userId);
  }
}

class _ProfileUpdateScreen extends StatefulWidget {
  final String fName;
  final String lName;
  final String address;
  final String email;
  final String password;
  final String userId;
  _ProfileUpdateScreen(
      {Key key,
      @required this.fName,
      @required this.lName,
      @required this.email,
      @required this.address,
      @required this.password,
      @required this.userId})
      : super(key: key);
  @override
  _ProfileUpdateScreenState createState() => _ProfileUpdateScreenState();
}

class _ProfileUpdateScreenState extends State<_ProfileUpdateScreen> {
  String selectedItem;
  double _registerBtnSize = 315;
  double _btnBorder = 4;
  bool _isLoading = false;
  final GlobalKey<ScaffoldState> mScaffoldState =
      new GlobalKey<ScaffoldState>();
  TextEditingController fnController = TextEditingController();
  TextEditingController lnController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController locController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  var webView = Container();
  ProgressDialog pr;

  var kGoogleApiKey = "AIzaSyAYTSuad8QcTO8EhZFGsV5PS1GdxRV2NdI";

  FocusNode _textFocus = new FocusNode();
  @override
  void initState() {
    // TODO: implement initState
    fnController.text = widget.fName;
    lnController.text = widget.lName;
    locController.text = widget.address;

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
                        "Profile Settings",
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

    final addressCard = Card(
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
                controller: locController,
                decoration: new InputDecoration(
                    icon: Image(
                      image: AssetImage("assets/images/location_icon.png"),
                      height: 40,
                      width: 40,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.my_location,
                        color: hexToColor("#eccd00"),
                      ),
                      // onPressed: getLocation,
                    ),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    contentPadding:
                        EdgeInsets.only(right: 8, bottom: 4, top: 10),
                    hintText: "Select Location"),
              ))
        ],
      ),
    );

    return Scaffold(
      backgroundColor: hexToColor("#f7fffb"),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            headerbar,
            SizedBox(
              height: 28,
            ),
            Align(
              alignment: Alignment.center,
              child: CircleAvatar(
                backgroundColor: hexToColor("#00a859"),
                radius: 80,
                child: Stack(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(
                        left: 5.0,
                        top: 5.0,
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          "assets/images/employer_green.png",
                          width: 150,
                          height: 150,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              margin: EdgeInsets.only(right: 20, left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Flexible(
                    child: Card(
                      elevation: 3,
                      color: hexToColor("#f7fffb"),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      borderOnForeground: true,
                      child: new TextField(
                        textAlign: TextAlign.left,
                        controller: fnController,
                        decoration: new InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            contentPadding:
                                EdgeInsets.only(left: 12, right: 8, bottom: 4),
                            hintText: "First Name"),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Flexible(
                    child: Card(
                      elevation: 3,
                      color: hexToColor("#f7fffb"),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      borderOnForeground: true,
                      child: new TextField(
                        controller: lnController,
                        textAlign: TextAlign.left,
                        decoration: new InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            contentPadding:
                                EdgeInsets.only(left: 12, right: 8, bottom: 4),
                            hintText: "Last Name"),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 16,
            ),
            addressCard,
            SizedBox(
              height: 16,
            ),
            AnimatedContainer(
              duration: Duration(milliseconds: 500),
              child: GestureDetector(
                onTap: () {
                  _updateTap();
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
                          "UPDATE PROFILE",
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
    print("id ${widget.userId}");
    if (fnController.text.isNotEmpty &&
        lnController.text.isNotEmpty &&
        locController.text.isNotEmpty) {
      setState(() {
        _isLoading = true;
        _registerBtnSize = 80;
        _btnBorder = 20;
      });
      HttpControllers()
          .updateProfile(
              fName: fnController.text,
              lName: lnController.text,
              email: widget.email,
              address: locController.text,
              id: widget.userId)
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
        }
        if (status == '200') {
          // Success

          setState(() {
            showToast('Account updated Successfully!',
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
                MaterialPageRoute(builder: (context) => HomePage()));
          });
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

  Color hexToColor(String code) {
    return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }
  // Future<String> getProfilePreference() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //
  //   fnController.text = prefs.getString("first_name");
  //   lnController.text = prefs.getString("last_name");
  //   emailController.text = prefs.getString("email");
  //   locController.text = prefs.getString("address");
  //   passwordController.text = prefs.getString("password");
  //
  // }

}

BoxDecoration myBoxDecoration() {
  return BoxDecoration(
    border: Border.all(width: 1.0, color: Colors.grey),
    borderRadius:
        BorderRadius.all(Radius.circular(5.0) //         <--- border radius here
            ),
  );
}

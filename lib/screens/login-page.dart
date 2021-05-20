import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:seooptimization/snack_bar.dart';
import 'package:seooptimization/screens/register-page.dart';
import 'package:seooptimization/controllers/http_controllers.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';
import 'package:seooptimization/widgets/circular_progress.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_page.dart';

class LoginPage extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return _LoginPage(title: 'Login');
  }
}

class _LoginPage extends StatefulWidget {
  _LoginPage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _LoginPageState createState() => _LoginPageState();
}

enum SingingCharacter { lafayette, jefferson }

class _LoginPageState extends State<_LoginPage> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  TextStyle style_head = TextStyle(fontFamily: 'Montserrat', fontSize: 24.0);
  TextEditingController email_Controller = TextEditingController();
  TextEditingController password_Controller = TextEditingController();
  SingingCharacter _character = SingingCharacter.lafayette;
  Future<http.Response> _response;
  ProgressDialog pr;
  final GlobalKey<ScaffoldState> mScaffoldState =
      new GlobalKey<ScaffoldState>();
  bool _isLoading = false;

  bool _obscureText = true;
  var keepColor;
  String _password;
  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  var keepVal = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    keepColor = hexToColor("#f7fffb");
    pr = ProgressDialog(
      context,
      isDismissible: true,
    );

    pr.style(
        message: ' Loading...',
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

  @override
  Widget build(BuildContext context) {
    final img_semi_circle = Container(
        margin: EdgeInsets.only(top: 40),
        child: Stack(
          children: <Widget>[
            Image.asset(
              'assets/images/SEOlogin.png',
            ),
          ],
        ));

    final emailCard = Card(
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
              margin: EdgeInsets.only(top: 6, left: 8),
              child: TextFormField(
                controller: email_Controller,
                textAlign: TextAlign.left,
                decoration: new InputDecoration(
                    icon: Image(
                      image: AssetImage("assets/images/user_icon.png"),
                      height: 40,
                      width: 40,
                    ),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    contentPadding: EdgeInsets.only(right: 8, bottom: 4),
                    hintText: "Email"),
              ))
        ],
      ),
    );

    final passwordCard = Card(
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
                controller: password_Controller,
                textAlign: TextAlign.left,
                obscureText: _obscureText,
                decoration: new InputDecoration(
                    icon: Image(
                      image: AssetImage("assets/images/lock.png"),
                      height: 40,
                      width: 40,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.remove_red_eye),
                      onPressed: _toggle,
                    ),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    contentPadding:
                        EdgeInsets.only(right: 8, bottom: 4, top: 10),
                    hintText: "Password"),
              ))
        ],
      ),
    );

    final keep = Container(
        margin: EdgeInsets.only(left: 26, right: 24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              child: Row(
                children: <Widget>[
                  //Image(image: AssetImage("assets/images/circle.png"), width: 20, height: 20,),

                  InkWell(
                    onTap: () {
                      setState(() {
                        if (keepVal == false) {
                          keepColor = hexToColor("#00a859");
                          keepVal = true;
                        } else {
                          keepColor = hexToColor("#f7fffb");
                          keepVal = false;
                        }
                      });
                    },
                    child: CircleAvatar(
                      radius: 10,
                      backgroundColor: Colors.black,
                      child: CircleAvatar(
                        backgroundColor: hexToColor("#f7fffb"),
                        radius: 9.5,
                        child: CircleAvatar(
                          radius: 8.0,
                          backgroundColor: keepColor,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        if (keepVal == false) {
                          keepColor = hexToColor("#00a859");
                          keepVal = true;
                        } else {
                          keepColor = hexToColor("#f7fffb");
                          keepVal = false;
                        }
                      });
                    },
                    child: Text("Keep me logged in"),
                  ),
                ],
              ),
            ),
            //Text("Forgot Password?",style: TextStyle(color: hexToColor("#00a859")),),
          ],
        ));

    final loginBtn = AnimatedContainer(
      duration: Duration(milliseconds: 500),
      child: GestureDetector(
        onTap: () {
          _loginTap();
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
                  "LOGIN",
                  textAlign: TextAlign.center,
                  style: style.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
        ),
      ),
    );

    final signupBar = Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("Don't have an account? "),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RegisterPage(),
                ),
              );
            },
            child: new Text(
              "Sign up",
              style: TextStyle(color: hexToColor("#00a859")),
            ),
          ),
        ],
      ),
    );

    final joinText = Align(
      alignment: Alignment.center,
      child: Image(
        image: AssetImage("assets/images/join_text.png"),
      ),
    );

    final socialBar = Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          InkWell(
            onTap: () {},
            child: Image(
              image: AssetImage("assets/images/fb_icon.png"),
              width: 40,
              height: 40,
            ),
          ),
          SizedBox(
            width: 15,
          ),
          InkWell(
            onTap: () {
              // signInWithGoogle().whenComplete(() {
              //   loginGoogleUser();
              // });
            },
            child: Image(
              image: AssetImage("assets/images/google_icon.png"),
              width: 40,
              height: 40,
            ),
          ),
        ],
      ),
    );

    final agreementBar = Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        //your elements here
        Text(
          "By log in you agree to Seo Optimization Activities Authority",
          style: TextStyle(fontSize: 13),
        ),
        SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Condition",
                style: TextStyle(color: hexToColor("#00a859"), fontSize: 13)),
            Text(
              " of use and ",
              style: TextStyle(fontSize: 13),
            ),
            Text("Privacy Policy",
                style: TextStyle(color: hexToColor("#00a859"), fontSize: 13))
          ],
        )
      ],
    );

    Widget _home = Container();

//hexToColor("#f7fffb")

    return Scaffold(
      key: mScaffoldState,
      resizeToAvoidBottomInset: false,
      backgroundColor: hexToColor("#f7fffb"),
      body: SingleChildScrollView(
        child: Container(
          color: hexToColor("#f7fffb"),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              img_semi_circle,
              SizedBox(
                height: 36,
              ),
              emailCard,
              SizedBox(
                height: 8,
              ),
              passwordCard,
              SizedBox(
                height: 30,
              ),

              loginBtn,
              SizedBox(
                height: 20,
              ),
              signupBar,
              SizedBox(
                height: 30,
              ),
              joinText,
              SizedBox(
                height: 20,
              ),
              socialBar,
              SizedBox(
                height: 35,
              ),
              agreementBar,
            ],
          ),
        ),
      ),
    );
  }

  _loginTap() async {
    if (email_Controller.text.isNotEmpty &&
        password_Controller.text.isNotEmpty) {
      setState(() {
        _isLoading = true;
      });
      HttpControllers()
          .login(
        email: email_Controller.text,
        password: password_Controller.text,
      )
          .then((response) {
        setState(() {
          _isLoading = false;
        });
        String msg = 'Unpredicted Error';
        var message;
        var status;
        print("all $response");
        for (int i = 0; i < response.length; i++) {
          status = response[i]["response"];
          message = response[i]["msg"];
        }

        if (status == '200') {
          if (message == "Please first confirm your registration to login") {
            msg = "$message";
          } else if (message == "Username is incorrect") {
            msg = "$message";
          } else if (message == "Password is Incorrect") {
            msg = "$message";
          } else {
            var value = message.substring(24, 25);
            email_Controller.text = '';
            password_Controller.text = '';
            saveUserId(value);
            msg = "login successfully";
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(),
              ),
            );
          }
        } else if (response == '55') {
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

  Future saveUserId(var id) async {
    SharedPreferences userInfo = await SharedPreferences.getInstance();
    userInfo.setString("UserId", id);
    userInfo?.setBool("isLoggedIn", true);
  }

  Color hexToColor(String code) {
    return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }
}

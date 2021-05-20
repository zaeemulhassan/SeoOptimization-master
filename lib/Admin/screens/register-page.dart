import 'dart:async';
import 'package:location/location.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:geocoder/geocoder.dart';
import 'package:seooptimization/Admin/screens/login-page.dart';
import 'package:seooptimization/Admin/snack_bar.dart';
import 'package:seooptimization/Admin/controllers/http_controllers.dart';
import 'package:seooptimization/Admin/widgets/circular_progress.dart';

class RegisterPage extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return _RegisterPage(title: 'Register');
  }
}

class _RegisterPage extends StatefulWidget {
  _RegisterPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

enum SingingCharacter { lafayette, jefferson }

class _RegisterPageState extends State<_RegisterPage> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  TextStyle style_head = TextStyle(fontFamily: 'Montserrat', fontSize: 24.0);
  TextEditingController fnController = TextEditingController();
  TextEditingController lnController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController locController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  BuildContext mContext;
  bool _obscureText = true;
  bool _obscureText2 = true;
  double _registerBtnSize = 315;
  double _btnBorder = 4;
  bool _isLoading = false;
  final GlobalKey<ScaffoldState> mScaffoldState =
      new GlobalKey<ScaffoldState>();

  List<String> _colors = <String>['', 'red', 'green', 'blue', 'orange'];
  var resultsList = 'red';
  ProgressDialog pr;

  // Toggles the password show status
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

  @override
  void initState() {
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
    mContext = context;

    final img_semi_circle = Stack(
      children: <Widget>[
        Image.asset(
          'assets/images/SEOlogin.png',
        ),
      ],
    );
    final back = Align(
      alignment: Alignment.topLeft,
      child: Container(
        margin: EdgeInsets.only(top: 34.0, left: 8.0),
        child: Row(
          children: <Widget>[
            InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Icon(
                Icons.arrow_back_ios,
                color: hexToColor("#00a859"),
                size: 25,
              ),
            ),
          ],
        ),
      ),
    );
    final signinBar = Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("Already have an account? "),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginPage(),
                ),
              );
            },
            child: new Text(
              "Sign in",
              style: TextStyle(color: hexToColor("#00a859")),
            ),
          ),
        ],
      ),
    );
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
                textAlign: TextAlign.left,
                controller: emailController,
                decoration: new InputDecoration(
                    icon: Image(
                      image: AssetImage("assets/images/email.png"),
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
                textAlign: TextAlign.left,
                obscureText: _obscureText,
                controller: passwordController,
                decoration: new InputDecoration(
                    icon: Image(
                      image: AssetImage("assets/images/lock.png"),
                      height: 40,
                      width: 40,
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
                    hintText: "Password"),
              ))
        ],
      ),
    );

    final passwordConfirmationCard = Card(
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
                obscureText: _obscureText2,
                controller: confirmPasswordController,
                decoration: new InputDecoration(
                    icon: Image(
                      image: AssetImage("assets/images/lock.png"),
                      height: 40,
                      width: 40,
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
                    hintText: "Confirm Password"),
              ))
        ],
      ),
    );

    final userCard = Card(
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
                controller: userNameController,
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
                    hintText: "Username"),
              ))
        ],
      ),
    );

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
                      onPressed: getLocation,
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


    final registerBtn = AnimatedContainer(
      duration: Duration(milliseconds: 500),
      child: GestureDetector(
        onTap: () {
          Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
          RegExp regex = new RegExp(pattern);

          if (fnController.text.isEmpty) {
            Sbar().showSnackBar(
                "Enter your first name", mScaffoldState);
          }
          else if (lnController.text.isEmpty) {
            Sbar().showSnackBar(
                "Enter your last name", mScaffoldState);
          }

          else if (emailController.text.isEmpty) {
            Sbar().showSnackBar(
                "Enter your email", mScaffoldState);
          }
          else if (locController.text.isEmpty) {
            Sbar().showSnackBar(
                "Enter your address", mScaffoldState);
          }
          else if (passwordController.text.isEmpty) {
            Sbar().showSnackBar(
                "Enter your password", mScaffoldState);
          }
          else if (confirmPasswordController.text.isEmpty) {
            Sbar().showSnackBar(
                "Enter your confirm password", mScaffoldState);
          }
          else if (passwordController.text.length <= 7) {
            Sbar().showSnackBar(
                "Password should not be less than 8 character",
                mScaffoldState);
          }
          else
          if (passwordController.text != confirmPasswordController.text) {
            Sbar().showSnackBar(
                "Both password should be same", mScaffoldState);
          }

          else if (!(regex.hasMatch(emailController.text))) {
            Sbar().showSnackBar(
                "Invalid email", mScaffoldState);
          }

          else {
            _registerTap();

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
                  "START NOW",
                  textAlign: TextAlign.center,
                  style: style.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
        ),
      ),
    );

    final joinText = Align(
      alignment: Alignment.center,
      child: Image(
        image: AssetImage("assets/images/join_text.png"),
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

    final firstLastName = Container(
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
    );

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
              back,
              SizedBox(
                height: 10,
              ),
              img_semi_circle,
              SizedBox(
                height: 26,
              ),
              firstLastName,
              SizedBox(
                height: 8,
              ),
              addressCard,
              SizedBox(
                height: 8,
              ),
              emailCard,
              SizedBox(
                height: 8,
              ),
              passwordCard,
              SizedBox(
                height: 8,
              ),
              passwordConfirmationCard,
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 30,
              ),
              registerBtn,
              SizedBox(
                height: 20,
              ),
              signinBar,
              SizedBox(
                height: 20,
              ),
              joinText,
              SizedBox(
                height: 35,
              ),
              agreementBar,
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void btnClicked() {
    Fluttertoast.showToast(msg: "Invalid Number");
  }

  Color hexToColor(String code) {
    return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }

  _registerTap() {
    if (fnController.text.isNotEmpty &&
        lnController.text.isNotEmpty &&
        locController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty) {
      setState(() {
        _isLoading = true;
        _registerBtnSize = 80;
        _btnBorder = 20;
      });
      HttpControllers()
          .registerUser(
        firstName: fnController.text,
        lastName: lnController.text,
        email: emailController.text,
        location: locController.text,
        password: passwordController.text,
      )
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
        print("all $message");
        if (status == '200') {
          if (message == "Admin Already Exists With This Email") {
            msg = "$message";
          } else {
            fnController.text = '';
            lnController.text = '';
            emailController.text = '';
            locController.text = '';
            passwordController.text = '';
            confirmPasswordController.text = '';

            msg = "$message";
          }
        } else if (response == '22') {
          // Database Error
          msg = 'Server is not responding!';
        } else if (response == '33') {
          // Unpredicted Error
          msg = 'Unpredicted Error';
        } else if (response == '44') {
          // Already Exists
          msg = 'Already Registered. Please Login!';
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

  Future<void> getLocation() async {
    FocusScope.of(context).requestFocus(FocusNode());
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();

    final coordinates =
        new Coordinates(_locationData.latitude, _locationData.longitude);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);

    var first = addresses.first;
    locController.text = first.addressLine.toString();

//    location.onLocationChanged.listen((LocationData currentLocation) {
//      // Use current location
//    });
  }

  // final FirebaseAuth _auth = FirebaseAuth.instance;
  // final GoogleSignIn googleSignIn = GoogleSignIn();
  // FirebaseUser googleUser;

  // Future<String> signInWithGoogle() async {
  //   final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  //   final GoogleSignInAuthentication googleSignInAuthentication =
  //   await googleSignInAccount.authentication;
  //
  //   final AuthCredential credential = GoogleAuthProvider.getCredential(
  //     accessToken: googleSignInAuthentication.accessToken,
  //     idToken: googleSignInAuthentication.idToken,
  //   );
  //
  //   final AuthResult authResult = await _auth.signInWithCredential(credential);
  //   final FirebaseUser user = authResult.user;
  //   assert(!user.isAnonymous);
  //   assert(await user.getIdToken() != null);
  //
  //   final FirebaseUser currentUser = await _auth.currentUser();
  //   assert(user.uid == currentUser.uid);
  //
  //   googleUser = user;
  //   return 'signInWithGoogle succeeded: $user';
  // }
  //
  // String your_client_id = "347537516095173";
  // String your_redirect_url =
  //     "https://www.facebook.com/connect/login_success.html";
  // FirebaseUser fbUser;
  //
  // loginWithFacebook() async {
  //   String result = await Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //         builder: (context) => CustomWebView(
  //           selectedUrl:
  //           'https://www.facebook.com/dialog/oauth?client_id=$your_client_id&redirect_uri=$your_redirect_url&response_type=token&scope=email,public_profile,',
  //         ),
  //         maintainState: true),
  //   );
  //
  //   if (result != null) {
  //     try {
  //       final facebookAuthCred =
  //       FacebookAuthProvider.getCredential(accessToken: result);
  //
  //       final FirebaseAuth _auth = FirebaseAuth.instance;
  //
  //       final user = await _auth.signInWithCredential(facebookAuthCred);
  //       fbUser = user.user;
  //       return 'signInWithGoogle succeeded: $user';
  //     } catch (e) {
  //       print(e.toString());
  //     }
  //   }
  // }

}

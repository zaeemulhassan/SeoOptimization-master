import 'package:seooptimization/Admin/screens/web_screen.dart';
import 'package:currency_picker/currency_picker.dart';
import 'package:flag/flag.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:seooptimization/screens/discussion_page.dart';
import 'package:seooptimization/screens/update_profile_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:seooptimization/screens/change_password_page.dart';

import 'UserSplashScreen.dart';

class ProfilePage extends StatelessWidget {
  final String fName;
  final String lName;
  final String address;
  final String email;
  final String userId;
  final String password;
  ProfilePage(
      {Key key,
      @required this.fName,
      @required this.lName,
      @required this.address,
      @required this.email,
      @required this.userId,
      @required this.password})
      : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return _ProfilePage(
        address: address,
        email: email,
        fName: fName,
        lName: lName,
        userId: userId,
        password: password);
  }
}

class _ProfilePage extends StatefulWidget {
  final String fName;
  final String lName;
  final String address;
  final String email;
  final String userId;
  final String password;
  _ProfilePage(
      {Key key,
      @required this.fName,
      @required this.lName,
      @required this.address,
      @required this.email,
      @required this.userId,
      @required this.password})
      : super(key: key);
  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<_ProfilePage> {
  TextStyle style =
      TextStyle(fontFamily: 'Montserrat', fontSize: 22.0, color: Colors.white);
  TextStyle style_sub =
      TextStyle(fontFamily: 'Montserrat', fontSize: 16.0, color: Colors.white);
  String type;
  Text typeTxt = Text('');
  Text NamePlusAgeTxt = Text('');
  Text ratingTxt = Text('');
  Text country = Text('');
  Text memberSince = Text('');
  Image imgNetwork = Image.network("");
  NetworkImage imgNetwork_profile = NetworkImage("");
  Widget middleCard = Container();
  var hasRun = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final backImg = Container(
        width: MediaQuery.of(context).size.width,
        height: 360,
        child: Stack(
          children: <Widget>[
            Container(height: 310, child: imgNetwork),
            Container(
              //margin: EdgeInsets.only(bottom: 16.0),
              height: 410,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    const Color(0xCC000000),
                    const Color(0xC000000),
                    const Color(0xCC000000),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: PopupMenuButton<int>(
                padding: EdgeInsets.only(top: 36.0, right: 8.0),
                icon: Icon(
                  Icons.more_vert,
                  color: Colors.white,
                ),
                offset: Offset(0, 40),
                onSelected: (value) {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: Text(
                            ('Are you sure you want to sign out?'),
                            style: TextStyle(
                                fontFamily: 'Cabin', color: Colors.black),
                          ),
                          backgroundColor: Colors.white,
                          actions: [
                            FlatButton(
                              child: Text(('Yes')),
                              onPressed: () async {
                                _signOut();
                                Navigator.of(context).pop();
                              },
                            ),
                            FlatButton(
                              child: Text(('No')),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      });
                },
                itemBuilder: (context) => [
                  PopupMenuItem(
                    height: 30,
                    value: 1,
                    child: Text(
                      "Logout",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.only(top: 36.0),
                child: Text(
                  "${widget.fName} " + "${widget.lName}",
                  style: style,
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                margin: EdgeInsets.only(top: 36.0, left: 8.0),
                child: Row(
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      width: 1,
                    ),
                    Text(
                      "Back",
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 16.0,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                  top: 80, left: (MediaQuery.of(context).size.width / 2) - 70),
              width: 140,
              height: 140,
              child: CircleAvatar(
                radius: 65,
                backgroundColor: hexToColor("#00a859"),
                child: CircleAvatar(
                  radius: 65,
                  backgroundImage: AssetImage("assets/images/freelancer_green.png"),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 230),
              child: Align(
                alignment: Alignment.center,
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.email,
                          color: hexToColor("#00a859"),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "${widget.email}",
                          style: style_sub,
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.location_on_rounded,
                          color: hexToColor("#00a859"),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child:
                        Text(
                          "${widget.address}",
                          style: style_sub,
                        ),)
                      ],
                    ),
                    SizedBox(height: 8),
                  ],
                ),
              ),
            ),
          ],
        ));
    final Favourite = Container(
        height: 60,
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(right: 18, left: 18),
        child: InkWell(
          onTap: () {
            Navigator.push(context,
              MaterialPageRoute(
                builder: (context) => DiscussionScreen(),
              ),
            );
          },
          child: Card(
            elevation: 3,
            color: hexToColor("#f7fffb"),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6.0),
            ),
            borderOnForeground: true,
            child: InkWell(
              child: Stack(
                alignment: Alignment.centerLeft,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Icon(
                      Icons.message,
                      color: hexToColor("#00a859"),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 48.0),
                    child: Text(
                      "Discussion",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: Icon(
                        Icons.arrow_forward,
                        color: hexToColor("#00a859"),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));

    final profileUpdate = Container(
        height: 60,
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(right: 18, left: 18),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProfileUpdateScreen(
                  fName: widget.fName,
                  lName: widget.lName,
                  email: widget.email,
                  address: widget.address,
                  password: widget.password,
                  userId: widget.userId,
                ),
              ),
            );
          },
          child: Card(
            elevation: 3,
            color: hexToColor("#f7fffb"),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6.0),
            ),
            borderOnForeground: true,
            child: InkWell(
              child: Stack(
                alignment: Alignment.centerLeft,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Icon(
                      Icons.person,
                      color: hexToColor("#00a859"),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 48.0),
                    child: Text(
                      "Update Profile",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: Icon(
                        Icons.arrow_forward,
                        color: hexToColor("#00a859"),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
    final changePassword = Container(
        height: 60,
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(right: 18, left: 18),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    ChangePasswordScreen(text: "Change Password"),
              ),
            );
          },
          child: Card(
            elevation: 3,
            color: hexToColor("#f7fffb"),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6.0),
            ),
            borderOnForeground: true,
            child: InkWell(
              child: Stack(
                alignment: Alignment.centerLeft,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Icon(
                      Icons.lock,
                      color: hexToColor("#00a859"),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 48.0),
                    child: Text(
                      "Change Password",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: Icon(
                        Icons.arrow_forward,
                        color: hexToColor("#00a859"),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));

    final helpAndSupport = Container(
        height: 60,
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(right: 18, left: 18),
        child: Card(
          elevation: 3,
          color: hexToColor("#f7fffb"),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6.0),
          ),
          borderOnForeground: true,
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      WebScreen("https://web.gigxlife.com/page/privacy-policy"),
                ),
              );
            },
            child: Stack(
              alignment: Alignment.centerLeft,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Icon(
                    Icons.help,
                    color: hexToColor("#00a859"),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 48.0),
                  child: Text(
                    "Help and Support",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.only(right: 8.0),
                    child: Icon(
                      Icons.arrow_forward,
                      color: hexToColor("#00a859"),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));

    final privacyPolicy = Container(
        height: 60,
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(right: 18, left: 18),
        child: Card(
          elevation: 3,
          color: hexToColor("#f7fffb"),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6.0),
          ),
          borderOnForeground: true,
          child: InkWell(
            onTap: () {
              // Navigator.push(context,
              //   MaterialPageRoute(
              //     builder: (context) => WebScreen("https://web.gigxlife.com/page/privacy-policy"),
              //   ),
              // );
            },
            child: Stack(
              alignment: Alignment.centerLeft,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Icon(
                    Icons.lock,
                    color: hexToColor("#00a859"),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 48.0),
                  child: Text(
                    "Privacy Policy",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.only(right: 8.0),
                    child: Icon(
                      Icons.arrow_forward,
                      color: hexToColor("#00a859"),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
    final customerSupport = Container(
        height: 60,
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(right: 18, left: 18),
        child: Card(
          elevation: 3,
          color: hexToColor("#f7fffb"),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6.0),
          ),
          borderOnForeground: true,
          child: InkWell(
            onTap: () {
              Navigator.push(context,
                MaterialPageRoute(
                  builder: (context) => WebScreen("https://discord.gg/bkbWDmwm7H"),
                ),
              );
            },
            child: Stack(
              alignment: Alignment.centerLeft,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Icon(
                    Icons.support_agent,
                    color: hexToColor("#00a859"),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 48.0),
                  child: Text(
                    "Customer Support",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.only(right: 8.0),
                    child: Icon(
                      Icons.arrow_forward,
                      color: hexToColor("#00a859"),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
    final termAndCond = Container(
        height: 60,
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(right: 18, left: 18),
        child: Card(
          elevation: 3,
          color: hexToColor("#f7fffb"),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6.0),
          ),
          borderOnForeground: true,
          child: InkWell(
            onTap: () {
              // Navigator.push(context,
              //   MaterialPageRoute(
              //     builder: (context) => WebScreen("https://web.gigxlife.com/page/privacy-policy"),
              //   ),
              // );
            },
            child: Stack(
              alignment: Alignment.centerLeft,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Icon(
                    Icons.info,
                    color: hexToColor("#00a859"),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 48.0),
                  child: Text(
                    "Term and Condition",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.only(right: 8.0),
                    child: Icon(
                      Icons.arrow_forward,
                      color: hexToColor("#00a859"),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));

    final logoutBtn = Container(
        height: 60,
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(right: 18, left: 18),
        child: Card(
          elevation: 3,
          color: hexToColor("#f7fffb"),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6.0),
          ),
          borderOnForeground: true,
          child: InkWell(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: Text(
                        ('Are you sure you want to sign out?'),
                        style:
                            TextStyle(fontFamily: 'Cabin', color: Colors.black),
                      ),
                      backgroundColor: Colors.white,
                      actions: [
                        FlatButton(
                          child: Text(('Yes')),
                          onPressed: () async {
                            _signOut();
                            Navigator.of(context).pop();
                          },
                        ),
                        FlatButton(
                          child: Text(('No')),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  });
            },
            child: Stack(
              alignment: Alignment.centerLeft,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Icon(
                    Icons.logout,
                    color: hexToColor("#00a859"),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 48.0),
                  child: Text(
                    "Logout",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.only(right: 8.0),
                    child: Icon(
                      Icons.arrow_forward,
                      color: hexToColor("#00a859"),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: hexToColor("#f7fffb"),
      body: Builder(
        builder: (context) {
          return SingleChildScrollView(
            child: Container(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                backImg,
                SizedBox(
                  height: 8,
                ),

                profileUpdate,
                SizedBox(
                  height: 8,
                ),
                changePassword,
                SizedBox(
                  height: 8,
                ),
                Favourite,
                SizedBox(
                  height: 8,
                ),
                helpAndSupport,
                SizedBox(
                  height: 8,
                ),
                privacyPolicy,
                SizedBox(
                  height: 8,
                ),
                termAndCond,
                SizedBox(
                  height: 8,
                ),
                customerSupport,
                SizedBox(
                  height: 8,
                ),
                logoutBtn
              ],
            )),
          );
        },
      ),
    );
  }

  Color hexToColor(String code) {
    return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }

  void _signOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    await Future.delayed(Duration(seconds: 1));

    Navigator.of(context).pushAndRemoveUntil(
      // the new route
      MaterialPageRoute(
        builder: (BuildContext context) => UserSplashScreen(),
      ),

      // this function should return true when we're done removing routes
      // but because we want to remove all other screens, we make it
      // always return false
      (Route route) => false,
    );
  }
}

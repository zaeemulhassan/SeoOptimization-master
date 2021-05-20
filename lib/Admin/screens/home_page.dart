import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:seooptimization/Admin/screens/free_guide_page.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:seooptimization/Admin/screens/add_free_tips.dart';
import 'package:seooptimization/Admin/screens/navigation_page.dart';
import 'package:seooptimization/Admin/screens/profile_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatelessWidget {
  final String text;
  HomePage({Key key, @required this.text}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Home',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: _HomePage(text: text),
    );
  }
}

class _HomePage extends StatefulWidget {
  _HomePage({Key key, this.text}) : super(key: key);
  final String text;

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<_HomePage> {
  var currentUserId;
  int _page = 0;
  var fName;
  var lName;
  var address;
  var email;
  var password;
  GlobalKey _bottomNavigationKey = GlobalKey<CurvedNavigationBarState>();

  Widget homeImage = CircleAvatar(
    backgroundColor: Colors.transparent,
    child: SvgPicture.asset(
      "assets/images/home_icon.svg",
      color: Colors.white,
    ),
  );

  Widget femaleImg = CircleAvatar(
    backgroundColor: Colors.transparent,
    child: SvgPicture.asset(
      "assets/images/services_icon.svg",
      color: Colors.white,
      width: 32,
      height: 32,
    ),
  );

  Widget manImg = CircleAvatar(
    backgroundColor: Colors.transparent,
    child: SvgPicture.asset(
      "assets/images/jobs.svg",
      color: Colors.white,
    ),
  );

  Widget agentImg = CircleAvatar(
    backgroundColor: Colors.transparent,
    child: SvgPicture.asset(
      "assets/images/agent_icon.svg",
      color: Colors.white,
    ),
  );

  Widget profileImg = CircleAvatar(
    backgroundColor: Colors.transparent,
    child: SvgPicture.asset(
      "assets/images/employer_icon.svg",
      color: Colors.white,
    ),
  );

//  Image homeImg =  Image(image: AssetImage("assets/images/text_icon.png"),color: Colors.white,) ;
//  Image agentImg = Image(image: AssetImage("assets/images/agent_icon.png"),color: Colors.white,) ;
//  Image femaleImg = Image(image: AssetImage("assets/images/services_icon.png"),color: Colors.white,) ;
//  Image manImg = Image(image: AssetImage("assets/images/job_icon.png"),color: Colors.white,) ;
// Image profileImg = Image(image: AssetImage("assets/images/employer_icon.png"),color: Colors.white,) ;
  Widget titleBar = Container();
  Widget home = Container();

  static BuildContext mContext;

  @override
  void initState() {
    test();
    super.initState();
    getIdPreference();
    getHomePage();
  }

  Future test() async {
    Future.delayed(Duration(seconds: 5)).then((_) {});
  }

  @override
  Widget build(BuildContext context) {
    mContext = context;
    titleBar = Container(
      margin: EdgeInsets.only(top: 16, right: 16, left: 16),
      height: 60,
      child: Stack(
        children: <Widget>[
          Align(
              alignment: Alignment.topLeft,
              child: InkWell(
                onTap: () {
                  getDrawer();
                },
                child: Image(
                  image: AssetImage("assets/images/nav_menu_icon.png"),
                  width: 25,
                  height: 25,
                ),
              )),
          Align(
              alignment: Alignment.center,
              child: Container(
                //color: Colors.yellow,
                margin: EdgeInsets.only(bottom: 8.0),
                child: Image(
                  image: AssetImage("assets/images/logoo.png"),
                  width: 150,
                  height: 80,
                ),
              )),
          Align(
              alignment: Alignment.topRight,
              child: Icon(
                Icons.notifications,
                color: hexToColor("#00a859"),
                size: 30,
              ))
        ],
      ),
    );

    return WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: hexToColor("#f7fffb"),
            bottomNavigationBar: CurvedNavigationBar(
              color: hexToColor("#00a859"),
              backgroundColor: hexToColor("#f7fffb"),
              key: _bottomNavigationKey,
              items: <Widget>[
                homeImage,
                femaleImg,
                agentImg,
                manImg,
                profileImg
              ],
              onTap: (index) {
                print('index: $index | page: $_page');
                if (index == 2) {
                } else {
                  setState(() {
                    _page = index;
                    getPage();
                  });
                }
              },
            ),
            body: home));
  }

  Color hexToColor(String code) {
    return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }

  getPage() async {
//HomeFragment(text: "Home",)
    if (_page == 0) {
      home = Container(
        child: FutureBuilder(
            future: Future.delayed(Duration(milliseconds: 600)),
            builder: (c, s) => s.connectionState == ConnectionState.done
                ? Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 32),
                          child: titleBar,
                          height: 70,
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height - 102 - 75,
                          child: FreePosts(
                            text: "Guide",
                          ),
                        )
                      ],
                    ),
                  )
                : Container(
                    height: MediaQuery.of(context).size.height,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )),
      );
    }

    if (_page == 1) {
      home = Container(
        child: FutureBuilder(
            future: Future.delayed(Duration(milliseconds: 600)),
            builder: (c, s) => s.connectionState == ConnectionState.done
                ? Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 32),
                          child: titleBar,
                          height: 60,
                        ),
                        Container(
                            height:
                                MediaQuery.of(context).size.height - 102 - 65,
                            child: AddTipsScreen(
                              text: "Add Tips",
                            ))
                      ],
                    ),
                  )
                : Container(
                    height: MediaQuery.of(context).size.height,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )),
      );
    } else if (_page == 3) {
      home = Container(
        child: FutureBuilder(
            future: Future.delayed(Duration(milliseconds: 600)),
            builder: (c, s) => s.connectionState == ConnectionState.done
                ? Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 32),
                          child: titleBar,
                          height: 60,
                        ),
                        Container(
                            height:
                                MediaQuery.of(context).size.height - 102 - 65,
                            child: Text("hello"))
                      ],
                    ),
                  )
                : Container(
                    height: MediaQuery.of(context).size.height,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )),
      );
    } else if (_page == 2) {
      home = Container(
        child: FutureBuilder(
            future: Future.delayed(Duration(milliseconds: 600)),
            builder: (c, s) => s.connectionState == ConnectionState.done
                ? Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 32),
                          child: titleBar,
                          height: 70,
                        ),
                        Container(
                            height:
                                MediaQuery.of(context).size.height - 102 - 75,
                            child: Text("hello"))
                      ],
                    ),
                  )
                : Container(
                    height: MediaQuery.of(context).size.height,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )),
      );
    }

    if (_page == 4) {
      home = Container(
        child: FutureBuilder(
            future: Future.delayed(Duration(milliseconds: 600)),
            builder: (c, s) => s.connectionState == ConnectionState.done
                ? Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 32),
                          child: titleBar,
                          height: 70,
                        ),
                        Container(
                            height:
                                MediaQuery.of(context).size.height - 102 - 75,
                            child: Text("hello"))
                      ],
                    ),
                  )
                : Container(
                    height: MediaQuery.of(context).size.height,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )),
      );
    }
  }

  void getHomePage() {
    home = Container(
      child: FutureBuilder(
          future: Future.delayed(Duration(milliseconds: 600)),
          builder: (c, s) => s.connectionState == ConnectionState.done
              ? Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 32),
                        child: titleBar,
                        height: 70,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height - 102 - 75,
                        child: FreePosts(
                          text: "Home",
                        ),
                      )
                    ],
                  ),
                )
              : Container(
                  height: MediaQuery.of(context).size.height,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )),
    );
  }

  Future<void> getDrawer() async {
    Navigator.of(context).push(SlideRightRoute(
        page: ProfilePage(
      fName: fName,
      lName: lName,
      email: email,
      address: address,
      userId: currentUserId,
      password: password,
    )));
  }

  Future<String> getIdPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    currentUserId = prefs.getString("UserId");
    if (mounted)
      setState(() {
        getProfile();
      });

    return prefs.getString("UserId");
  }

  Future getProfile() async {
    print("token $currentUserId");
    var url = Uri.parse(
        'http://139.59.80.110:8187/seo/profile?user_id=$currentUserId');

    var response =
        await http.get(url, headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      Map<String, dynamic> map = jsonDecode(response.body);
      var data = map;
      print("profile $data");
      if (data.length > 0) {
        setState(() {
          fName = data["first_name"];
          lName = data["last_name"];
          address = data["address"];
          email = data["email"];
          password = data["password"];
        });
        saveUserProfile(fName, lName, address, email, password);

        //
        // print("all $result");
      } else {
        debugPrint("Access Denied");
      }
    }
  }

  Future saveUserProfile(
      var firstName, var lastName, var address, var email, var password) async {
    SharedPreferences userInfo = await SharedPreferences.getInstance();
    userInfo.setString("firstName", firstName);
    userInfo.setString("lastName", lastName);
    userInfo.setString("address", address);
    userInfo.setString("email", email);
    userInfo.setString("password", password);
  }

  Future<bool> _onWillPop() {
    return showDialog(
            context: context,
            builder: (BuildContext context) {
              return SimpleDialog(
                contentPadding: EdgeInsets.only(
                    left: 0.0, right: 0.0, top: 0.0, bottom: 0.0),
                children: <Widget>[
                  Container(
                    color: Colors.green[400],
                    margin: EdgeInsets.all(0.0),
                    padding: EdgeInsets.only(bottom: 10.0, top: 10.0),
                    height: 100.0,
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: Icon(
                            Icons.exit_to_app,
                            size: 30.0,
                            color: Colors.white,
                          ),
                          margin: EdgeInsets.only(bottom: 10.0),
                        ),
                        Text(
                          'Exit app',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Are you sure to exit app?',
                          style: TextStyle(color: Colors.white, fontSize: 14.0),
                        ),
                      ],
                    ),
                  ),
                  SimpleDialogOption(
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    child: Row(
                      children: <Widget>[
                        Container(
                          child: Icon(
                            Icons.cancel,
                            color: Colors.black,
                          ),
                          margin: EdgeInsets.only(right: 10.0),
                        ),
                        Text(
                          'CANCEL',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  SimpleDialogOption(
                    onPressed: () => exit(0),
                    child: Row(
                      children: <Widget>[
                        Container(
                          child: Icon(
                            Icons.check_circle,
                            color: Colors.black,
                          ),
                          margin: EdgeInsets.only(right: 10.0),
                        ),
                        Text(
                          'YES',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ],
              );
            }) ??
        false;
  }
}

class SlideRightRoute extends PageRouteBuilder {
  final Widget page;
  SlideRightRoute({this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(-1, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
}

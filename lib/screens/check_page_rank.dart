import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:seooptimization/controllers/http_controllers.dart';
import 'package:seooptimization/widgets/circular_progress.dart';

import '../snack_bar.dart';

class CheckRankScreen extends StatelessWidget {
  final String text;
  CheckRankScreen({Key key, @required this.text}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return _CheckRankScreen();
  }
}

class _CheckRankScreen extends StatefulWidget {
  _CheckRankScreen({Key key}) : super(key: key);
  @override
  _CheckRankScreenState createState() => _CheckRankScreenState();
}

class _CheckRankScreenState extends State<_CheckRankScreen> {
  String selectedItem;

  TextEditingController domainController = TextEditingController();
  final GlobalKey<ScaffoldState> mScaffoldState =
      new GlobalKey<ScaffoldState>();
  TextStyle style =
      TextStyle(fontFamily: 'Montserrat', fontSize: 20.0, color: Colors.black);
  var webView = Container();
  ProgressDialog pr;
  bool _isLoading = false;

  FocusNode _textFocus = new FocusNode();

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textCard = Container(
      child: Center(
          child: Image.asset(
        "assets/images/seo.png",
        fit: BoxFit.fill,
      )),
    );

    final domainCard = Card(
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
                controller: domainController,
                decoration: new InputDecoration(
                    icon: Icon(
                      Icons.web,
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
                    hintText: "Website Domain"),
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
              height: 10,
            ),
            textCard,
            SizedBox(
              height: 30,
            ),
            domainCard,
            SizedBox(
              height: 50,
            ),
            AnimatedContainer(
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
                          "Check",
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

  _loginTap() {
    if (domainController.text.isNotEmpty) {
      setState(() {
        _isLoading = true;
      });
      HttpControllers()
          .getRank(
        domain: domainController.text,
      )
          .then((response) {
        print("data ${response.length}");
        var rank;
        var status;
        for (int i = 0; i < response.length; i++) {
          rank = response[i]["rank"];
          status = response[i]["status_code"];
        }
        print("status $status");
        setState(() {
          _isLoading = false;
        });
        String msg;

        if (status == 200) {
          domainController.text = '';

          msg = "your page rank is $rank";
        } else if (status == 404) {
          // Already Exists
          msg = 'Use correct domain';
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
}

BoxDecoration myBoxDecoration() {
  return BoxDecoration(
    border: Border.all(width: 1.0, color: Colors.grey),
    borderRadius:
        BorderRadius.all(Radius.circular(5.0) //         <--- border radius here
            ),
  );
}

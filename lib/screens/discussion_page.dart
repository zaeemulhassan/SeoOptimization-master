import 'dart:io';
import 'package:intl/intl.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:seooptimization/controllers/http_controllers.dart';
import 'dart:async';
import 'dart:convert';
import 'package:seooptimization/widgets/timeago.dart';
import 'package:seooptimization/widgets/circular_progress.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../snack_bar.dart';

class DiscussionScreen extends StatefulWidget {
  @override
  _DiscussionScreenState createState() => _DiscussionScreenState();
}

class _DiscussionScreenState extends State<DiscussionScreen> {

  final GlobalKey<ScaffoldState> mScaffoldState =
  new GlobalKey<ScaffoldState>();
  var id;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  new GlobalKey<RefreshIndicatorState>();
  List document = [];
  bool isLoading = false;
  var currentDateTime;
  String formattedDate;
  var fName;
  var lName;
  var name = [];
  var message = [];
  var dateTime = [];
  TextEditingController commentController = TextEditingController();
  @override
  void initState() {
    super.initState();
  _getDiscussion();
  getUserPreference();
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
                        "Discussion",
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
    return Scaffold(
        key: mScaffoldState,
        body:RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: () async => await _getDiscussion(),
    child: Column(
            children: <Widget>[
              SizedBox(
                height: 5,
              ),
              headerbar,
              Expanded(child:
              ListView(
                children:[
                  isLoading
                      ? Center(
                    child: CircularProgress(),
                  )
                      : buildGetComments(),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
              ),
              Expanded(
                  flex: -3,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                        margin: const EdgeInsets.all(10),
                        child: Row(
                          // textDirection: TextDirection.RTL
                          children: <Widget>[
                            Expanded(
                                child: TextFormField(
                                  controller: commentController,
                                  decoration: new InputDecoration(
                                      hintText: "Enter message",
                                      hintStyle: TextStyle(color: Colors.black)),
                                )),
                            IconButton(icon: Icon(Icons.send), onPressed: () {
                              DateTime now = new DateTime.now();
                              formattedDate = DateFormat('dd-MM-yyyy h:mma').format(now);
                              currentDateTime = formattedDate;
                              if(commentController.text.isEmpty){
                                Sbar().showSnackBar(
                                    "Please enter your comment", mScaffoldState);
                              }
                              else{
                                setState(() {
                                  isLoading = true;
                                });
                                _addDiscussion();
                               _getDiscussion();
                                commentController.text = "";
                              }
                            }),

                          ],
                        )),
                  ))
            ]))
    );
  }

  Widget buildGetComments() {
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      decoration: BoxDecoration(
//                  color: Colors.lightGreen[100],
      ),
      child: ListView.builder(
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          itemCount: name.length,
          itemBuilder: (BuildContext context, index) {
            return InkWell(
                onTap: () {},
                child: Card(
                    elevation: 3,
                    child: ListTile(
                      leading:Icon(Icons.account_circle_rounded,size: 25,),
                      title:Row(
                          children:[
                            Expanded(
                              child:
                              Text(
                                name[index],
                                style: TextStyle(fontSize: 17, color: Colors.black,fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(width: 15,),
                            Expanded(
                                child:
                                Text(
                                  TimeAgo.timeAgoSinceDate(dateTime[index]),
                                  style: TextStyle(fontSize: 14, color: Colors.black54),
                                )
                            )
                          ]
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Divider(),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            message[index],
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'EmojiOne',
                            ),
                          )
                        ],
                      ),
                    )));
          }),
    );
  }

  Color hexToColor(String code) {
    return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }
  Future _getDiscussion() async {
    name.clear();
    message.clear();
    dateTime.clear();
    await HttpControllers().getDiscussion().then((response) {
      setState(() => isLoading = false);
      if (response != 'zero') {
        var extractedData = json.decode(response);
        print("data 1 $extractedData");
        for (int i = 0; i < extractedData.length; i++) {
          name.add(extractedData[i]["name"]);
          message.add(extractedData[i]["message"]);
          dateTime.add(extractedData[i]["message_time"]);
        }
      } else {
        debugPrint("Access Denied");
      }
    });
  }
  _addDiscussion() {
    if (commentController.text.isNotEmpty) {
      setState(() {
        isLoading = true;
      });
      HttpControllers()
          .addDiscussion(
          name: fName ,
          message: commentController.text)
          .then((response) {
        setState(() {
          isLoading = false;
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
          msg = "Your message has been transferred";
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
  Future getUserPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    fName = prefs.getString("firstName");
    lName = prefs.getString("lastName");

  }
}
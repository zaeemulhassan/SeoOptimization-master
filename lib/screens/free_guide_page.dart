import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'package:http/http.dart';
import 'package:seooptimization/controllers/http_controllers.dart';
import 'package:seooptimization/screens/navigation_page.dart';
import 'package:seooptimization/widgets/circular_progress.dart';

class FreePosts extends StatelessWidget {
  final String text;

  FreePosts({Key key, @required this.text}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Home',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: _FreePosts(),
    );
  }
}

class _FreePosts extends StatefulWidget {
  _FreePosts({Key key}) : super(key: key);

  @override
  _FreePostsState createState() => _FreePostsState();
}

class _FreePostsState extends State<_FreePosts> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 22.0);
  Widget freelancerContainer = Container();

  Widget jobsContainer = Container();

  var kGoogleApiKey = "AIzaSyAYTSuad8QcTO8EhZFGsV5PS1GdxRV2NdI";
  Widget servicesContainer = Container();
  TextEditingController txtSrch = new TextEditingController();

  Position position;
  String locText;
  Color locBarBackColor, locBarIconColor, locTextColor;
  var isLocClicked = false;
  String noFreelancer, noService, noJobs;
  Widget crosslocationIcon;
  final fromTextController = TextEditingController();
  String fromCurrency = "USD";
  String toCurrency;
  String currencySymbol;
  var result = [];
  bool _isLoading = true;
  var title = [];
  var description = [];
  @override
  void initState() {
    _getTips();
    super.initState();

    locText = "Location";
    locBarBackColor = hexToColor("#f7fffb");
    locBarIconColor = hexToColor("#00a859");
    locTextColor = Colors.black;
    crosslocationIcon = Icon(
      Icons.cancel,
      color: locBarBackColor,
    );
  }

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  Future<Null> _handleRefresh() async {
    await new Future.delayed(new Duration(seconds: 2));
    setState(() {
      jobsContainer = Container();
      servicesContainer = Container();
      freelancerContainer = Container();
      result.clear();
    });

    return null;
  }

  @override
  Widget build(BuildContext context) {
    final titleBar = Container(
      margin: EdgeInsets.only(top: 16),
      height: 60,
      child: Stack(
        children: <Widget>[
          Align(
              alignment: Alignment.centerLeft,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NavigationDrawer(
                              text: "null",
                            )),
                  );
                },
                child: Image(
                  image: AssetImage("assets/images/nav_menu_icon.png"),
                  width: 25,
                  height: 25,
                ),
              )),
          Align(
            alignment: Alignment.topCenter,
            child: Image(
              image: AssetImage("assets/images/horizontal_logo.png"),
              width: 150,
              height: 55,
            ),
          ),
          Align(
              alignment: Alignment.centerRight,
              child: Icon(
                Icons.notifications,
                color: hexToColor("#00a859"),
                size: 30,
              ))
        ],
      ),
    );

    final searchPlusFilter = Container(
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 58,
            width: MediaQuery.of(context).size.width - 142,
            child: InkWell(
              onTap: () {
                // HomePageState.navigateToSearchPage();
              },
              child: Container(
                decoration: myBoxDecoration(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(width: 4.0),
                    Icon(
                      Icons.search,
                      color: hexToColor("#00a859"),
                    ),
                    SizedBox(width: 8.0),
                    Text(
                      "I'm looking for",
                      style: TextStyle(fontSize: 18, color: Colors.black54),
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Container(
            width: 100,
            height: 58,
            child: FlatButton.icon(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  side: BorderSide(color: hexToColor("#00a859"))),
              color: hexToColor("#00a859"),
              icon: Image(
                image: AssetImage("assets/images/filter_icon.png"),
                width: 20,
                height: 20,
              ),
              //`Icon` to display
              label: Text(
                'Filter',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              //`Text` to display
              onPressed: () {
                // HomePageState.navigateToFilterPage();
              },
            ),
          ),
        ],
      ),
    );

    return Scaffold(
        backgroundColor: hexToColor("#f7fffb"),
        body: _isLoading
            ? Align(
                alignment: Alignment.center,
                child: CircularProgress(),
              )
            : RefreshIndicator(
                // ignore: missing_return
                onRefresh: _handleRefresh,
                child: SingleChildScrollView(
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 16,
                        ),
                        Container(

                            // padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                            // height: 328,

                            child: ListView.builder(
                                shrinkWrap: true,
                                physics: BouncingScrollPhysics(),
                                itemCount: title.length,
                                itemBuilder: (context, index) {
                                  var heart = Image(
                                    image:
                                        AssetImage("assets/images/heart.png"),
                                    height: 20,
                                    width: 20,
                                    color: Colors.black12,
                                  );
                                  // if (jobs[index].favorit != "") {
                                  //   heart = Image(
                                  //     image: AssetImage("assets/images/heart.png"),
                                  //     height: 20,
                                  //     width: 20,
                                  //     color: Colors.red,
                                  //   );
                                  // }

                                  return Container(
                                    height: 288,
                                    child: Stack(
                                      children: <Widget>[
                                        Container(
                                          height: 288,
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 2.0, vertical: 0.0),
                                          color: hexToColor("#f7fffb"),
                                          child: Card(
                                            color: hexToColor("#f7fffb"),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16.0),
                                            ),
                                            elevation: 8.0,
                                            child: Stack(
                                              children: <Widget>[
                                                Align(
                                                  alignment: Alignment.topLeft,
                                                  child: Container(
                                                    width: 50,
                                                    height: 25,
                                                    decoration: BoxDecoration(
                                                        color: hexToColor(
                                                            "#00a859"),
                                                        shape: BoxShape
                                                            .rectangle,
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        16.0),
                                                                bottomRight: Radius
                                                                    .circular(
                                                                        35.0))),
                                                    child: Center(
                                                        child: Padding(
                                                      padding: EdgeInsets.only(
                                                          right: 3.0),
                                                      child: Icon(
                                                        Icons.ac_unit,
                                                        size: 16,
                                                        color: Colors.white,
                                                      ),
                                                    )),
                                                  ),
                                                ),
                                                Align(
                                                  alignment:
                                                      Alignment.bottomRight,
                                                  child: Container(
                                                    width: 150,
                                                    height: 20,
                                                    margin: EdgeInsets.only(
                                                        left: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width -
                                                            170),
                                                    decoration: BoxDecoration(
                                                        color: hexToColor(
                                                            "#00a859"),
                                                        shape: BoxShape
                                                            .rectangle,
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                bottomRight: Radius
                                                                    .circular(
                                                                        16.0),
                                                                topLeft: Radius
                                                                    .circular(
                                                                        35.0))),
                                                    child: Center(
                                                      child: Text(
                                                        "Tips",
                                                        style: TextStyle(
                                                            fontSize: 9.0,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      left: 56.0, top: 8.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: <Widget>[
                                                      CircleAvatar(
                                                        radius: 12,
                                                        backgroundImage:
                                                            NetworkImage(
                                                                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTzxsnQGyD2z9UBq4Xq64Hngxthwf_fL9n-rA&usqp=CAU"),
                                                        backgroundColor:
                                                            hexToColor(
                                                                "#00a859"),
                                                      ),
                                                      SizedBox(
                                                        width: 4,
                                                      ),
                                                      Text(
                                                        "Admin",
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            color: Colors.grey),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(
                                                    left: 16.0,
                                                    top: 40.0,
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      Container(
                                                        height: 20,
                                                        width: 20,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: hexToColor(
                                                              "#00a859"),
                                                          shape: BoxShape
                                                              .rectangle,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          50)),
                                                        ),
                                                        child: Center(
                                                          child: Icon(
                                                            Icons.done,
                                                            color: Colors.white,
                                                            size: 15,
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 6,
                                                      ),
                                                      Container(
                                                        height: 50,
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width -
                                                            16 -
                                                            26 -
                                                            28,
                                                        child: Text(
                                                          "${title[index]}",
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                              color: hexToColor(
                                                                  "#00a859"),
                                                              fontSize: 20.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  height: 128,
                                                  margin: EdgeInsets.only(
                                                      left: 18.0, top: 92.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: <Widget>[
                                                      Container(
                                                        height: 128,
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width -
                                                            160,
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  8.0),
                                                          child:
                                                              SingleChildScrollView(
                                                            child: Text(
                                                              "${description[index]}",
                                                              textAlign:
                                                                  TextAlign
                                                                      .justify,
                                                              maxLines: 50,
                                                              style: TextStyle(
                                                                fontSize: 12.0,
                                                                color:
                                                                    Colors.grey,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Align(
                                                  alignment: Alignment.topRight,
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 8.0, top: 212.0),
                                                    child: Container(
                                                      width: 120,
                                                      height: 40,
                                                      margin: EdgeInsets.only(
                                                          left: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width -
                                                              156,
                                                          bottom: 20),
                                                      child: RaisedButton(
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5.0),
                                                            side: BorderSide(
                                                                color: hexToColor(
                                                                    "#00a859"))),
                                                        onPressed: () {
                                                          // HomePageState.navigateToDetailJobPage(
                                                          //     jobs[index]);
                                                        },
                                                        color: hexToColor(
                                                            "#00a859"),
                                                        textColor: Colors.white,
                                                        child: Text(
                                                            "View Details"
                                                                .toUpperCase(),
                                                            style: TextStyle(
                                                                fontSize: 13)),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.topRight,
                                          child: Container(
                                            margin: EdgeInsets.only(
                                                left: MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    84),
                                            height: 50,
                                            width: 50,
                                            child: Card(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(50.0),
                                              ),
                                              elevation: 8.0,
                                              color: hexToColor("#f7fffb"),
                                              child: Center(child: heart),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }))
                      ],
                    ),
                  ),
                )));
  }

  Color hexToColor(String code) {
    return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }

  Future _getTips() async {
    await HttpControllers().getTips().then((response) {
      setState(() => _isLoading = false);
      if (response != 'zero') {
        var extractedData = json.decode(response);
        print("data 1 $extractedData");
        for (int i = 0; i < extractedData.length; i++) {
          title.add(extractedData[i]["title"]);
          description.add(extractedData[i]["description"]);
        }
      } else {
        debugPrint("Access Denied");
      }
    });
  }

  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
      border: Border.all(width: 1.0, color: hexToColor("#00a859")),
      borderRadius: BorderRadius.all(
          Radius.circular(5.0) //         <--- border radius here
          ),
    );
  }
}

/*

 latestURLGetFreelancers =
            Utils.baseURL + Utils.GET_FREELANCERS + "?listing_type=latest";
        latestURLGetJobs =
            Utils.baseURL + Utils.GET_JOBS + "?listing_type=latest";
        latestURLGetServices =
            Utils.baseURL + Utils.GET_SERVICES + "?listing_type=latest";

 */

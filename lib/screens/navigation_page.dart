import 'dart:async';
import 'dart:convert';

import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:seooptimization/screens/register-page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login-page.dart';



class NavigationDrawer extends StatelessWidget {

  final String text;
  NavigationDrawer({Key key, @required this.text}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return  _NavigationDrawer();

  }
}

class _NavigationDrawer extends StatefulWidget {
  _NavigationDrawer({Key key}) : super(key: key);
  @override
  _NavigationDrawerState createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<_NavigationDrawer> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 22.0);
  TextStyle style_sub = TextStyle(fontFamily: 'Montserrat', fontSize: 16.0);

  _NavigationDrawerState(){
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }



  @override
  Widget build(BuildContext context) {

    final greenBar  = Container(
        width: MediaQuery.of(context).size.width,
        height: 350,

        child: Stack(
          children: <Widget>[

            Container(
              height: 300,
              color: hexToColor("#00a859"),
            ),



            Align(
              alignment: Alignment.topRight,
              child: Container(
                margin: EdgeInsets.only(top:48.0, right:12.0),
                child: Icon(Icons.camera_alt,color: Colors.white,),
              ),
            ),



            Align(
              alignment: Alignment.topLeft,
              child: InkWell(
                onTap: (){
                  Navigator.of(context).pop();
                },
                child: Container( //
                  margin: EdgeInsets.only(top:48.0, left:8.0),
                  child: Row(
                    children: <Widget>[
                      InkWell(
                        onTap: (){
                          Navigator.of(context).pop();
                        },
                        child:  Icon(Icons.arrow_back_ios,color: Colors.white,),
                      ),
                      SizedBox(width: 1,),
                      Text("Back",style: TextStyle(fontFamily: 'Montserrat',fontSize: 16.0,
                        color: Colors.white,),)

                    ],
                  ),
                ),
              ),
            ),

            Container(
              margin: EdgeInsets.only(top: 80,left: (MediaQuery.of(context).size.width/2)-70),
              width: 140,
              height: 140,
              child: CircleAvatar(
                radius: 65,
                backgroundColor: hexToColor("#00a859"),
                child: CircleAvatar(
                  radius: 65,
                  backgroundColor: hexToColor("#00a859"),
                  backgroundImage: AssetImage("assets/images/login_circle.png"),
                ),
              ),
            ),

            Container(
              margin: EdgeInsets.only(top: 270),
              child: Align(
                alignment: Alignment.center,
                child: Column(
                  children: <Widget>[

                    Container(
                      width: MediaQuery. of(context). size. width,
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            width: (MediaQuery. of(context). size. width/2)-16-5,
                            child: InkWell(
                              onTap: (){
                                Navigator.push(context,
                                  MaterialPageRoute(
                                    builder: (context) => LoginPage(),
                                  ),
                                );


//                                Navigator.pushAndRemoveUntil(
//                                  context,
//                                  MaterialPageRoute(
//                                    builder: (BuildContext context) => LoginPage(),
//                                  ),
//                                      (route) => false,
//                                );


                              },
                              child:  Card(
                                color: hexToColor("#f7fffb"),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                elevation: 8.0,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text("Sign In",style: TextStyle(color: hexToColor("#00a859"), fontSize: 16,
                                      fontWeight: FontWeight.w800)),
                                ),
                              ),
                            ),
                          ),

                          SizedBox(
                            width: 10,
                          ),

                          Container(
                            width: (MediaQuery. of(context). size. width/2)-16-5,
                            child: InkWell(
                              onTap: (){
                                Navigator.push(context,
                                  MaterialPageRoute(
                                    builder: (context) => RegisterPage(),
                                  ),
                                );
                              },
                              child: Card(
                                color: hexToColor("#f7fffb"),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                elevation: 8.0,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text("Join Gigx Life",style: TextStyle(color: hexToColor("#00a859"), fontSize: 16,
                                      fontWeight: FontWeight.w800)),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

            ),

          ],
        )
    );


    final currency  = Container(
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
            onTap: (){
              showCurrencyPicker(
                context: context,
                showFlag: false,
                showCurrencyName: true,
                showCurrencyCode: true,
                currencyFilter: <String>['EUR', 'GBP', 'USD', 'AUD', 'CAD', 'JPY', 'HKD', 'CHF', 'SEK', 'ILS','SGD','NDD','ZAR'
                  ,'CNY','INR','MYR','MXN','PKR','PHP','TWD','THB','TRY','AED'
                ],
                onSelect: (Currency currency) async {
                  SharedPreferences currencyInfo = await SharedPreferences.getInstance();
                  currencyInfo.setString("CurrencyCode", currency.code);
                  currencyInfo.setString("CurrencySymbol", currency.symbol);
                  print('Select currency: ${currency.symbol}');
                },

              );
            },
            child: Stack(
              alignment: Alignment.centerLeft,
              children: <Widget>[

                Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Icon(Icons.note_add, color: hexToColor("#00a859"),),
                ),

                Container(
                  margin: EdgeInsets.only(left: 48.0),
                  child: Text("Currency",style: TextStyle(fontSize: 18),),
                ),

                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.only(right: 8.0),
                    child: Icon(Icons.arrow_forward, color: hexToColor("#00a859"),),
                  ),
                ),


              ],
            ),
          ),

        )
    );
    final aboutUs  = Container(
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

            child: Stack(
              alignment: Alignment.centerLeft,
              children: <Widget>[

                Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Icon(Icons.note_add, color: hexToColor("#00a859"),),
                ),

                Container(
                  margin: EdgeInsets.only(left: 48.0),
                  child: Text("About Us",style: TextStyle(fontSize: 18),),
                ),

                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.only(right: 8.0),
                    child: Icon(Icons.arrow_forward, color: hexToColor("#00a859"),),
                  ),
                ),


              ],
            ),
          ),

        )
    );
    final terms  = Container(
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

            child: Stack(
              alignment: Alignment.centerLeft,
              children: <Widget>[

                Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Icon(Icons.note_add, color: hexToColor("#00a859"),),
                ),

                Container(
                  margin: EdgeInsets.only(left: 48.0),
                  child: Text("Terms and Condition",style: TextStyle(fontSize: 18),),
                ),

                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.only(right: 8.0),
                    child: Icon(Icons.arrow_forward, color: hexToColor("#00a859"),),
                  ),
                ),


              ],
            ),
          ),

        )
    );
    final privacy  = Container(
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

            child: Stack(
              alignment: Alignment.centerLeft,
              children: <Widget>[

                Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Icon(Icons.note_add, color: hexToColor("#00a859"),),
                ),

                Container(
                  margin: EdgeInsets.only(left: 48.0),
                  child: Text("Privacy Policy",style: TextStyle(fontSize: 18),),
                ),

                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.only(right: 8.0),
                    child: Icon(Icons.arrow_forward, color: hexToColor("#00a859"),),
                  ),
                ),


              ],
            ),
          ),

        )
    );
    final support  = Container(
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

            child: Stack(
              alignment: Alignment.centerLeft,
              children: <Widget>[

                Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Icon(Icons.note_add, color: hexToColor("#00a859"),),
                ),

                Container(
                  margin: EdgeInsets.only(left: 48.0),
                  child: Text("Gigx Life Support",style: TextStyle(fontSize: 18),),
                ),

                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.only(right: 8.0),
                    child: Icon(Icons.arrow_forward, color: hexToColor("#00a859"),),
                  ),
                ),


              ],
            ),
          ),

        )
    );


    return Scaffold(
      backgroundColor: hexToColor("#f7fffb"),
      body: Container(

        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[

              greenBar,
              currency,
              SizedBox(height: 8,),
              aboutUs,
              SizedBox(height: 8,),
              terms,
              SizedBox(height: 8,),
              privacy,
              SizedBox(height: 8,),
              support

            ],
          ),
        ),
      ),

    );
  }




  Color hexToColor(String code) {
    return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }
}

/*

Container(
              margin: EdgeInsets.only(top:200),
              width: MediaQuery. of(context). size. width,
              height: 50,
              child: Row(
                children: <Widget>[
                  Container(
                    width: (MediaQuery. of(context). size. width/2)-16-5,
                    child: Card(
                      color: hexToColor("#f7fffb"),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      elevation: 8.0,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text("Sign In",style: TextStyle(color: hexToColor("#00a859"), fontSize: 16,
                            fontWeight: FontWeight.w800)),
                      ),
                    ),
                  ),

                  SizedBox(
                    width: 10,
                  ),

                  Container(
                    width: (MediaQuery. of(context). size. width/2)-16-5,
                    child: Card(
                      color: hexToColor("#f7fffb"),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      elevation: 8.0,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text("Join Gigx Life",style: TextStyle(color: hexToColor("#00a859"), fontSize: 16,
                            fontWeight: FontWeight.w800)),
                      ),
                    ),
                  ),




                ],
              ),
            ),


 */



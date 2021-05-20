import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:seooptimization/controllers/http_controllers.dart';
import 'package:seooptimization/widgets/circular_progress.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import '../snack_bar.dart';

class SeoCheckerResultScreen extends StatelessWidget {
  final String text;
  SeoCheckerResultScreen({Key key, @required this.text}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return _SeoCheckerResultScreen();
  }
}

class _SeoCheckerResultScreen extends StatefulWidget {
  _SeoCheckerResultScreen({Key key}) : super(key: key);
  @override
  _SeoCheckerResultScreenState createState() => _SeoCheckerResultScreenState();
}

class _SeoCheckerResultScreenState extends State<_SeoCheckerResultScreen> {
  String selectedItem;
  double _currentValue = 60;
  double _markerValue = 58;
  double _firstMarkerSize = 10;
  double _annotationFontSize = 25;
  String _annotationValue = '60';
  String _cardAnnotationValue = '60';
  double _cardCurrentValue = 60;
  double _cardMarkerValue = 58;
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
    final projectName = Container(
      child: Text(
        "SEO audit for \n http://ww.google.com",
        style: TextStyle(fontSize: 18),
      ),
    );

    final generalInformation = Container(
        margin: const EdgeInsets.all(10),
        child: Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.all(5),
                child: Text(
                  "Meta Information",
                  style: TextStyle(fontSize: 15),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5.0),
                child: LinearPercentIndicator(
                  width: MediaQuery.of(context).size.width - 50,
                  animation: true,
                  lineHeight: 20.0,
                  animationDuration: 2000,
                  percent: 0.9,
                  animateFromLastPercent: true,
                  center: Text(
                    "90.0%",
                    style: TextStyle(color: Colors.white),
                  ),
                  linearStrokeCap: LinearStrokeCap.roundAll,
                  progressColor: Colors.green[400],
                  maskFilter: MaskFilter.blur(BlurStyle.solid, 3),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(5),
                child: Text(
                  "Page quality",
                  style: TextStyle(fontSize: 15),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5.0),
                child: LinearPercentIndicator(
                  width: MediaQuery.of(context).size.width - 50,
                  animation: true,
                  lineHeight: 20.0,
                  animationDuration: 2000,
                  percent: 1.0,
                  animateFromLastPercent: true,
                  center: Text(
                    "100.0%",
                    style: TextStyle(color: Colors.white),
                  ),
                  linearStrokeCap: LinearStrokeCap.roundAll,
                  progressColor: Colors.green[400],
                  maskFilter: MaskFilter.blur(BlurStyle.solid, 3),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(5),
                child: Text(
                  "Page structure",
                  style: TextStyle(fontSize: 15),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5.0),
                child: LinearPercentIndicator(
                  width: MediaQuery.of(context).size.width - 50,
                  animation: true,
                  lineHeight: 20.0,
                  animationDuration: 2000,
                  percent: 0.8,
                  animateFromLastPercent: true,
                  center: Text(
                    "80.0%",
                    style: TextStyle(color: Colors.white),
                  ),
                  linearStrokeCap: LinearStrokeCap.roundAll,
                  progressColor: Colors.green[400],
                  maskFilter: MaskFilter.blur(BlurStyle.solid, 3),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(5),
                child: Text(
                  "Links",
                  style: TextStyle(fontSize: 15),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5.0),
                child: LinearPercentIndicator(
                  width: MediaQuery.of(context).size.width - 50,
                  animation: true,
                  lineHeight: 20.0,
                  animationDuration: 2000,
                  percent: 0.6,
                  animateFromLastPercent: true,
                  center: Text(
                    "60.0%",
                    style: TextStyle(color: Colors.white),
                  ),
                  linearStrokeCap: LinearStrokeCap.roundAll,
                  progressColor: Colors.green[400],
                  maskFilter: MaskFilter.blur(BlurStyle.solid, 3),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(5),
                child: Text(
                  "Server",
                  style: TextStyle(fontSize: 15),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5.0),
                child: LinearPercentIndicator(
                  width: MediaQuery.of(context).size.width - 50,
                  animation: true,
                  lineHeight: 20.0,
                  animationDuration: 2000,
                  percent: 0.5,
                  animateFromLastPercent: true,
                  center: Text(
                    "50.0%",
                    style: TextStyle(color: Colors.white),
                  ),
                  linearStrokeCap: LinearStrokeCap.roundAll,
                  progressColor: Colors.green[400],
                  maskFilter: MaskFilter.blur(BlurStyle.solid, 3),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(5),
                child: Text(
                  "External",
                  style: TextStyle(fontSize: 15),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5.0),
                child: LinearPercentIndicator(
                  width: MediaQuery.of(context).size.width - 50,
                  animation: true,
                  lineHeight: 20.0,
                  animationDuration: 2000,
                  percent: 1.0,
                  animateFromLastPercent: true,
                  center: Text(
                    "100.0%",
                    style: TextStyle(color: Colors.white),
                  ),
                  linearStrokeCap: LinearStrokeCap.roundAll,
                  progressColor: Colors.green[400],
                  maskFilter: MaskFilter.blur(BlurStyle.solid, 3),
                ),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ));

    final firstRow = CircularPercentIndicator(
      radius: 140.0,
      lineWidth: 10.0,
      percent: 0.5,
      center: Text("50%"),
      circularStrokeCap: CircularStrokeCap.round,
      backgroundColor: Colors.grey,
      maskFilter: MaskFilter.blur(BlurStyle.solid, 3),
      linearGradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Colors.orange, Colors.yellow],
      ),
    );

    final titleCard = Container(
      margin: const EdgeInsets.fromLTRB(10, 5, 10, 0),
      child: ClipPath(
          child: Card(
              shape: Border(left: BorderSide(color: Colors.green, width: 5)),
              child: ExpansionTile(
                leading: Container(
                  margin: EdgeInsets.all(2),
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(width: 1, color: Colors.white)),
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                  ),
                ),
                title: Text(
                  "Title",
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
                ),
                children: <Widget>[
                  ListTile(
                    title: Text(
                      "hello",
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                  )
                ],
              ))),
    );
    final metaCard = Container(
        margin: const EdgeInsets.fromLTRB(10, 5, 10, 0),
        child: ClipPath(
          child: Card(
              shape: Border(left: BorderSide(color: Colors.red[500], width: 5)),
              child: ExpansionTile(
                leading: Container(
                  margin: EdgeInsets.all(2),
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                      color: Colors.red[500],
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(width: 1, color: Colors.white)),
                  child: Icon(
                    CupertinoIcons.info,
                    color: Colors.white,
                  ),
                ),
                title: Text(
                  "Meta Description",
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
                ),
                children: <Widget>[
                  ListTile(
                    title: Text(
                      "hello",
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                  )
                ],
              )),
        ));
    final crawlCard = Container(
        margin: const EdgeInsets.fromLTRB(10, 5, 10, 0),
        child: ClipPath(
          child: Card(
              shape:
                  Border(left: BorderSide(color: Colors.orange[500], width: 5)),
              child: ExpansionTile(
                leading: Container(
                  margin: EdgeInsets.all(2),
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                      color: Colors.orange[500],
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(width: 1, color: Colors.white)),
                  child: Icon(
                    CupertinoIcons.info,
                    color: Colors.white,
                  ),
                ),
                title: Text(
                  "Crawlability",
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
                ),
                children: <Widget>[
                  ListTile(
                    title: Text(
                      "hello",
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                  )
                ],
              )),
        ));
    final urlCard = Container(
        margin: const EdgeInsets.fromLTRB(10, 5, 10, 0),
        child: ClipPath(
          child: Card(
              shape: Border(left: BorderSide(color: Colors.green, width: 5)),
              child: ExpansionTile(
                leading: Container(
                  margin: EdgeInsets.all(2),
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(width: 1, color: Colors.white)),
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                  ),
                ),
                title: Text(
                  "URL",
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
                ),
                children: <Widget>[
                  ListTile(
                    title: Text(
                      "hello",
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                  )
                ],
              )),
        ));
    final languageCard = Container(
        margin: const EdgeInsets.fromLTRB(10, 5, 10, 0),
        child: ClipPath(
          child: Card(
              shape: Border(left: BorderSide(color: Colors.green, width: 5)),
              child: ExpansionTile(
                leading: Container(
                  margin: EdgeInsets.all(2),
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(width: 1, color: Colors.white)),
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                  ),
                ),
                title: Text(
                  "Language",
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
                ),
                children: <Widget>[
                  ListTile(
                    title: Text(
                      "hello",
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                  )
                ],
              )),
        ));
    final alternativeCard = Container(
        margin: const EdgeInsets.fromLTRB(10, 5, 10, 0),
        child: ClipPath(
          child: Card(
              shape: Border(left: BorderSide(color: Colors.green, width: 5)),
              child: ExpansionTile(
                leading: Container(
                  margin: EdgeInsets.all(2),
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(width: 1, color: Colors.white)),
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                  ),
                ),
                title: Text(
                  "Alternative Links",
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
                ),
                children: <Widget>[
                  ListTile(
                    title: Text(
                      "hello",
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                  )
                ],
              )),
        ));
    final otherTagsCard = Container(
        margin: const EdgeInsets.fromLTRB(10, 5, 10, 0),
        child: ClipPath(
          child: Card(
              shape: Border(left: BorderSide(color: Colors.green, width: 5)),
              child: ExpansionTile(
                leading: Container(
                  margin: EdgeInsets.all(2),
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(width: 1, color: Colors.white)),
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                  ),
                ),
                title: Text(
                  "Other Meta Tags",
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
                ),
                children: <Widget>[
                  ListTile(
                    title: Text(
                      "hello",
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                  )
                ],
              )),
        ));
    final domainCard = Container(
        margin: const EdgeInsets.fromLTRB(10, 5, 10, 0),
        child: ClipPath(
          child: Card(
              shape: Border(left: BorderSide(color: Colors.green, width: 5)),
              child: ExpansionTile(
                leading: Container(
                  margin: EdgeInsets.all(2),
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(width: 1, color: Colors.white)),
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                  ),
                ),
                title: Text(
                  "Domain",
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
                ),
                children: <Widget>[
                  ListTile(
                    title: Text(
                      "hello",
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                  )
                ],
              )),
        ));
    final pageUrlCard = Container(
        margin: const EdgeInsets.fromLTRB(10, 5, 10, 0),
        child: ClipPath(
          child: Card(
              shape: Border(left: BorderSide(color: Colors.green, width: 5)),
              child: ExpansionTile(
                leading: Container(
                  margin: EdgeInsets.all(2),
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(width: 1, color: Colors.white)),
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                  ),
                ),
                title: Text(
                  "Page Url",
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
                ),
                children: <Widget>[
                  ListTile(
                    title: Text(
                      "hello",
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                  )
                ],
              )),
        ));
    final charsetCard = Container(
        margin: const EdgeInsets.fromLTRB(10, 5, 10, 0),
        child: ClipPath(
          child: Card(
              shape: Border(left: BorderSide(color: Colors.red[500], width: 5)),
              child: ExpansionTile(
                leading: Container(
                  margin: EdgeInsets.all(2),
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                      color: Colors.red[500],
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(width: 1, color: Colors.white)),
                  child: Icon(
                    CupertinoIcons.info,
                    color: Colors.white,
                  ),
                ),
                title: Text(
                  "Charset encoding",
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
                ),
                children: <Widget>[
                  ListTile(
                    title: Text(
                      "hello",
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                  )
                ],
              )),
        ));
    final docCard = Container(
        margin: const EdgeInsets.fromLTRB(10, 5, 10, 0),
        child: ClipPath(
          child: Card(
              shape:
                  Border(left: BorderSide(color: Colors.orange[500], width: 5)),
              child: ExpansionTile(
                leading: Container(
                  margin: EdgeInsets.all(2),
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                      color: Colors.orange[500],
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(width: 1, color: Colors.white)),
                  child: Icon(
                    CupertinoIcons.info,
                    color: Colors.white,
                  ),
                ),
                title: Text(
                  "Doctype",
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
                ),
                children: <Widget>[
                  ListTile(
                    title: Text(
                      "hello",
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                  )
                ],
              )),
        ));
    final favIconCard = Container(
        margin: const EdgeInsets.fromLTRB(10, 5, 10, 0),
        child: ClipPath(
          child: Card(
              shape: Border(left: BorderSide(color: Colors.green, width: 5)),
              child: ExpansionTile(
                leading: Container(
                  margin: EdgeInsets.all(2),
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(width: 1, color: Colors.white)),
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                  ),
                ),
                title: Text(
                  "Favicon",
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
                ),
                children: <Widget>[
                  ListTile(
                    title: Text(
                      "hello",
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                  )
                ],
              )),
        ));

    final pageQualityText = Align(
        alignment: Alignment.centerLeft,
        child: Container(
          margin: const EdgeInsets.fromLTRB(20, 5, 20, 5),
          child: Text(
            "Page Quality",
            style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
          ),
        ));

    final contentCard = Container(
        margin: const EdgeInsets.fromLTRB(10, 5, 10, 0),
        child: ClipPath(
          child: Card(
              shape: Border(left: BorderSide(color: Colors.green, width: 5)),
              child: ExpansionTile(
                leading: Container(
                  margin: EdgeInsets.all(2),
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(width: 1, color: Colors.white)),
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                  ),
                ),
                title: Text(
                  "Content",
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
                ),
                children: <Widget>[
                  ListTile(
                    title: Text(
                      "hello",
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                  )
                ],
              )),
        ));
    final frameCard = Container(
        margin: const EdgeInsets.fromLTRB(10, 5, 10, 0),
        child: ClipPath(
          child: Card(
              shape: Border(left: BorderSide(color: Colors.green, width: 5)),
              child: ExpansionTile(
                leading: Container(
                  margin: EdgeInsets.all(2),
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(width: 1, color: Colors.white)),
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                  ),
                ),
                title: Text(
                  "Frames",
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
                ),
                children: <Widget>[
                  ListTile(
                    title: Text(
                      "hello",
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                  )
                ],
              )),
        ));
    final strongTagCard = Container(
        margin: const EdgeInsets.fromLTRB(10, 5, 10, 0),
        child: ClipPath(
          child: Card(
              shape: Border(left: BorderSide(color: Colors.green, width: 5)),
              child: ExpansionTile(
                leading: Container(
                  margin: EdgeInsets.all(2),
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(width: 1, color: Colors.white)),
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                  ),
                ),
                title: Text(
                  "Bold and strong tags",
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
                ),
                children: <Widget>[
                  ListTile(
                    title: Text(
                      "hello",
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                  )
                ],
              )),
        ));
    final imageSEOCard = Container(
        margin: const EdgeInsets.fromLTRB(10, 5, 10, 0),
        child: ClipPath(
          child: Card(
              shape: Border(left: BorderSide(color: Colors.red[500], width: 5)),
              child: ExpansionTile(
                leading: Container(
                  margin: EdgeInsets.all(2),
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                      color: Colors.red[500],
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(width: 1, color: Colors.white)),
                  child: Icon(
                    CupertinoIcons.info,
                    color: Colors.white,
                  ),
                ),
                title: Text(
                  "Image SEO",
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
                ),
                children: <Widget>[
                  ListTile(
                    title: Text(
                      "hello",
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                  )
                ],
              )),
        ));
    final socialCard = Container(
        margin: const EdgeInsets.fromLTRB(10, 5, 10, 0),
        child: ClipPath(
          child: Card(
              shape:
                  Border(left: BorderSide(color: Colors.orange[500], width: 5)),
              child: ExpansionTile(
                leading: Container(
                  margin: EdgeInsets.all(2),
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                      color: Colors.orange[500],
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(width: 1, color: Colors.white)),
                  child: Icon(
                    CupertinoIcons.info,
                    color: Colors.white,
                  ),
                ),
                title: Text(
                  "Social Netword",
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
                ),
                children: <Widget>[
                  ListTile(
                    title: Text(
                      "hello",
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                  )
                ],
              )),
        ));
    final httpCard = Container(
        margin: const EdgeInsets.fromLTRB(10, 5, 10, 0),
        child: ClipPath(
          child: Card(
              shape: Border(left: BorderSide(color: Colors.green, width: 5)),
              child: ExpansionTile(
                leading: Container(
                  margin: EdgeInsets.all(2),
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(width: 1, color: Colors.white)),
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                  ),
                ),
                title: Text(
                  "HTTPS",
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
                ),
                children: <Widget>[
                  ListTile(
                    title: Text(
                      "hello",
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                  )
                ],
              )),
        ));

    final pageStructureText = Align(
        alignment: Alignment.centerLeft,
        child: Container(
          margin: const EdgeInsets.fromLTRB(20, 5, 20, 5),
          child: Text(
            "Page Structure",
            style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
          ),
        ));

    final h1Card = Container(
        margin: const EdgeInsets.fromLTRB(10, 5, 10, 0),
        child: ClipPath(
          child: Card(
              shape: Border(left: BorderSide(color: Colors.green, width: 5)),
              child: ExpansionTile(
                leading: Container(
                  margin: EdgeInsets.all(2),
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(width: 1, color: Colors.white)),
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                  ),
                ),
                title: Text(
                  "H1 Heading",
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
                ),
                children: <Widget>[
                  ListTile(
                    title: Text(
                      "hello",
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                  )
                ],
              )),
        ));
    final headingCard = Container(
        margin: const EdgeInsets.fromLTRB(10, 5, 10, 0),
        child: ClipPath(
          child: Card(
              shape: Border(left: BorderSide(color: Colors.green, width: 5)),
              child: ExpansionTile(
                leading: Container(
                  margin: EdgeInsets.all(2),
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(width: 1, color: Colors.white)),
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                  ),
                ),
                title: Text(
                  "Headings",
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
                ),
                children: <Widget>[
                  ListTile(
                    title: Text(
                      "hello",
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                  )
                ],
              )),
        ));

    final linksText = Align(
        alignment: Alignment.centerLeft,
        child: Container(
          margin: const EdgeInsets.fromLTRB(20, 5, 20, 5),
          child: Text(
            "Links",
            style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
          ),
        ));

    final internalLinkCard = Container(
        margin: const EdgeInsets.fromLTRB(10, 5, 10, 0),
        child: ClipPath(
          child: Card(
              shape: Border(left: BorderSide(color: Colors.green, width: 5)),
              child: ExpansionTile(
                leading: Container(
                  margin: EdgeInsets.all(2),
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(width: 1, color: Colors.white)),
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                  ),
                ),
                title: Text(
                  "Internal links",
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
                ),
                children: <Widget>[
                  ListTile(
                    title: Text(
                      "hello",
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                  )
                ],
              )),
        ));
    final externalLinkCard = Container(
        margin: const EdgeInsets.fromLTRB(10, 5, 10, 0),
        child: ClipPath(
          child: Card(
              shape: Border(left: BorderSide(color: Colors.green, width: 5)),
              child: ExpansionTile(
                leading: Container(
                  margin: EdgeInsets.all(2),
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(width: 1, color: Colors.white)),
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                  ),
                ),
                title: Text(
                  "External links",
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
                ),
                children: <Widget>[
                  ListTile(
                    title: Text(
                      "hello",
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                  )
                ],
              )),
        ));

    final serverText = Align(
        alignment: Alignment.centerLeft,
        child: Container(
          margin: const EdgeInsets.fromLTRB(20, 5, 20, 5),
          child: Text(
            "Server",
            style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
          ),
        ));

    final httpRedirectCard = Container(
        margin: const EdgeInsets.fromLTRB(10, 5, 10, 0),
        child: ClipPath(
          child: Card(
              shape: Border(left: BorderSide(color: Colors.green, width: 5)),
              child: ExpansionTile(
                leading: Container(
                  margin: EdgeInsets.all(2),
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(width: 1, color: Colors.white)),
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                  ),
                ),
                title: Text(
                  "HTTP redirects",
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
                ),
                children: <Widget>[
                  ListTile(
                    title: Text(
                      "hello",
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                  )
                ],
              )),
        ));
    final httpHeaderCard = Container(
        margin: const EdgeInsets.fromLTRB(10, 5, 10, 0),
        child: ClipPath(
          child: Card(
              shape: Border(left: BorderSide(color: Colors.green, width: 5)),
              child: ExpansionTile(
                leading: Container(
                  margin: EdgeInsets.all(2),
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(width: 1, color: Colors.white)),
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                  ),
                ),
                title: Text(
                  "HTTP header",
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
                ),
                children: <Widget>[
                  ListTile(
                    title: Text(
                      "hello",
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                  )
                ],
              )),
        ));
    final performanceCard = Container(
        margin: const EdgeInsets.fromLTRB(10, 5, 10, 0),
        child: ClipPath(
          child: Card(
              shape: Border(left: BorderSide(color: Colors.green, width: 5)),
              child: ExpansionTile(
                leading: Container(
                  margin: EdgeInsets.all(2),
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(width: 1, color: Colors.white)),
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                  ),
                ),
                title: Text(
                  "Performance",
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
                ),
                children: <Widget>[
                  ListTile(
                    title: Text(
                      "hello",
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                  )
                ],
              )),
        ));

    final externalText = Align(
        alignment: Alignment.centerLeft,
        child: Container(
          margin: const EdgeInsets.fromLTRB(20, 5, 20, 5),
          child: Text(
            "External Factors",
            style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
          ),
        ));

    final backListCard = Container(
        margin: const EdgeInsets.fromLTRB(10, 5, 10, 0),
        child: ClipPath(
          child: Card(
              shape: Border(left: BorderSide(color: Colors.green, width: 5)),
              child: ExpansionTile(
                leading: Container(
                  margin: EdgeInsets.all(2),
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(width: 1, color: Colors.white)),
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                  ),
                ),
                title: Text(
                  "BackLists",
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
                ),
                children: <Widget>[
                  ListTile(
                    title: Text(
                      "hello",
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                  )
                ],
              )),
        ));
    final backLinkCard = Container(
        margin: const EdgeInsets.fromLTRB(10, 5, 10, 0),
        child: ClipPath(
          child: Card(
              shape: Border(left: BorderSide(color: Colors.green, width: 5)),
              child: ExpansionTile(
                leading: Container(
                  margin: EdgeInsets.all(2),
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(width: 1, color: Colors.white)),
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                  ),
                ),
                title: Text(
                  "Backlinks",
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
                ),
                children: <Widget>[
                  ListTile(
                    title: Text(
                      "hello",
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                  )
                ],
              )),
        ));
    final facebookCard = Container(
        margin: const EdgeInsets.fromLTRB(10, 5, 10, 0),
        child: ClipPath(
          child: Card(
              shape: Border(left: BorderSide(color: Colors.green, width: 5)),
              child: ExpansionTile(
                leading: Container(
                  margin: EdgeInsets.all(2),
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(width: 1, color: Colors.white)),
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                  ),
                ),
                title: Text(
                  "Facebook popularity",
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
                ),
                children: <Widget>[
                  ListTile(
                    title: Text(
                      "hello",
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                  )
                ],
              )),
        ));

    return Scaffold(
      key: mScaffoldState,
      backgroundColor: hexToColor("#f7fffb"),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            firstRow,
            SizedBox(
              height: 10,
            ),
            projectName,
            SizedBox(
              height: 10,
            ),
            generalInformation,
            SizedBox(
              height: 10,
            ),
            titleCard,
            // SizedBox(height: 10,),
            metaCard,
            crawlCard,
            urlCard,
            languageCard,
            otherTagsCard,
            domainCard,
            pageUrlCard,
            charsetCard,
            docCard,
            favIconCard,
            SizedBox(
              height: 10,
            ),
            pageQualityText,
            contentCard,
            frameCard,
            strongTagCard,
            imageSEOCard,
            socialCard,
            httpCard,
            SizedBox(
              height: 10,
            ),
            pageStructureText,
            h1Card,
            headingCard,
            SizedBox(
              height: 10,
            ),
            linksText,
            internalLinkCard,
            externalLinkCard,
            SizedBox(
              height: 10,
            ),
            serverText,
            httpHeaderCard,
            httpRedirectCard,
            performanceCard,
            SizedBox(
              height: 10,
            ),
            externalText,
            backLinkCard,
            backListCard,
            facebookCard,
            SizedBox(
              height: 20,
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

  SfRadialGauge _buildRangePointerExampleGauge() {
    return SfRadialGauge(
      axes: <RadialAxis>[
        RadialAxis(
            showLabels: false,
            showTicks: false,
            startAngle: 270,
            endAngle: 270,
            minimum: 0,
            maximum: 100,
            radiusFactor: 0.5,
            axisLineStyle: AxisLineStyle(
                thicknessUnit: GaugeSizeUnit.factor, thickness: 0.15),
            annotations: <GaugeAnnotation>[
              GaugeAnnotation(
                  angle: 180,
                  widget: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        child: Text(
                          '70 %',
                          style: TextStyle(
                              fontFamily: 'Times',
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.italic),
                        ),
                      ),
                      Container(
                        child: Text(
                          ' / 100',
                          style: TextStyle(
                              fontFamily: 'Times',
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.italic),
                        ),
                      )
                    ],
                  )),
            ],
            pointers: <GaugePointer>[
              RangePointer(
                  value: 70,
                  cornerStyle: CornerStyle.bothCurve,
                  enableAnimation: true,
                  animationDuration: 1200,
                  animationType: AnimationType.ease,
                  sizeUnit: GaugeSizeUnit.factor,
                  gradient: const SweepGradient(
                      colors: <Color>[Colors.green, Colors.lightGreen],
                      stops: <double>[0.25, 0.75]),
                  color: const Color(0xFF00A8B5),
                  width: 0.15),
            ]),
      ],
    );
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

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:seooptimization/screens/UserSplashScreen.dart';

import 'Admin/screens/SplashScreen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp( MyApp());
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: UserSplashScreen(),

    );
  }
}

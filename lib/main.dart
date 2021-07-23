import 'package:flutter/material.dart';
import 'package:flutter_miningwallet/constants.dart';
import 'package:flutter_miningwallet/screens/introScreen/introScreen.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: kPrimaryColor,
      ),
      home:IntroScreen(),
    );
  }
}


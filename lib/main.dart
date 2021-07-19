import 'package:flutter/material.dart';
import 'package:flutter_miningwallet/constants.dart';
import 'package:flutter_miningwallet/screens/Invite/invite.dart';
import 'package:flutter_miningwallet/screens/MainScreen/mainScreen.dart';
import 'package:flutter_miningwallet/screens/MyPage/MyPage.dart';
import 'package:flutter_miningwallet/screens/Notification/notification.dart';
import 'package:flutter_miningwallet/screens/Top100/BuildTop.dart';
import 'package:flutter_miningwallet/screens/introScreen/introScreen.dart';
import 'package:flutter_miningwallet/screens/membership/components/body.dart';
import 'package:flutter_miningwallet/screens/membership/membership.dart';


void main() {
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


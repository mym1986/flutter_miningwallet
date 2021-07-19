import 'package:flutter/material.dart';
import 'package:flutter_miningwallet/screens/membership/membership.dart';
import 'package:flutter_miningwallet/widgets/Panel_widget/Panelbody.dart';
import 'package:flutter_miningwallet/widgets/Panel_widget/Panel_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final panelController = PanelController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            height: 400,
            // color: Colors.black,
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 50,
                  ),
                  Image.asset(
                    "assets/images/GMClogo.png",
                    height: 120,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "GGM\nMining",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 40,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ]),
          ),
          SizedBox(
            height: 80,
          ),
          Container(
            height: 50,
            width: 240,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(5)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    // blurRadius: 1,
                    // spreadRadius: 1,
                    offset: Offset(0.5, 2),
                  )
                ]),
            child: OutlinedButton(
              onPressed: () {
                  // pressSignInGoogle();
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return BuildMembership();
                }));
              },
              child: Row(
                children: <Widget>[
                  SvgPicture.asset(
                    'assets/images/Google.svg',
                    height: 25,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Sign in with Google",
                          style: TextStyle(
                              color: Colors.black45,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ])
                ],
              ),
            ),
          ),
          SizedBox(
            height: 80,
          ),
          Container(
            width: size.width,
            child: Center(
              child: Text(
                "To want you to participate in our mine and\nclick on the login is to agree to the terms\nand conditions and to read and agree to\n the Privacy Policy and Terms.",
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            ),
          ),
        ]),
      ),
      // ),
    );
  }

  // void pressSignInGoogle() {
  //   FirebaseAuth auth = FirebaseAuth.instance;
  //   GoogleSignIn googleSignIn = GoogleSignIn();
  //
  // }
}

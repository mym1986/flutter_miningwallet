import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_miningwallet/repository/repository.dart';
import 'package:flutter_miningwallet/screens/MainScreen/mainscreen.dart';
import 'package:flutter_miningwallet/screens/membership/membership.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final panelController = PanelController();
  final userRepository = UserRepository();
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
                    "WBit\nMining",
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
                // signOut();
                signInWithGoogle();

                // Navigator.push(context, MaterialPageRoute(builder: (context) {
                //   return BuildMembership();
                // }));
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

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<String> signInWithGoogle() async {
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
    await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final AuthResult authResult = await _auth.signInWithCredential(credential);
    final FirebaseUser user = authResult.user;

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);

    String email = await userRepository.getUserEmail(user.email);

    if(email != null) {
      userRepository.persisteUser(email);
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return MainScreen();
      }));
    }else {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return BuildMembership(email: user.email);
      }));
    }

    return 'signInWithGoogle succeeded: ';
  }

  // Future<void> signInWithGoogle() async {
  //   final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  //   // final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
  //   if(googleUser != null) {
  //     String email = await userRepository.getUserEmail(googleUser.email);
  //     if(email != null) {
  //       userRepository.persisteUser(email);
  //       final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
  //       final OAuthCredential credential = GoogleAuthProvider.credential(
  //         accessToken: googleAuth.accessToken,
  //         idToken: googleAuth.idToken,
  //       );
  //       await _auth.signInWithCredential(credential);
  //       Navigator.push(context, MaterialPageRoute(builder: (context) {
  //         return MainScreen();
  //       }));
  //     }else {
  //       Navigator.push(context, MaterialPageRoute(builder: (context) {
  //         return BuildMembership(email: googleUser.email);
  //       }));
  //     }
  //   }
  //
  // }


  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      print("Success");
    } catch (e) {
      print(e.toString());
    }
  }
}

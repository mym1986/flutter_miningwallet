
import 'package:flutter/material.dart';
import 'package:flutter_miningwallet/repository/repository.dart';
import 'package:flutter_miningwallet/screens/Invite/invite.dart';
import 'package:flutter_miningwallet/screens/MainScreen/mainscreen.dart';
import 'package:flutter_miningwallet/screens/MyPage/MyPage.dart';
import 'package:flutter_miningwallet/screens/Notification/notification.dart';
import 'package:flutter_miningwallet/screens/Top100/BuildTop.dart';
import 'package:flutter_miningwallet/screens/Transaction/Transaction.dart';
import 'package:flutter_miningwallet/screens/introScreen/introScreen.dart';
import 'package:flutter_miningwallet/widgets/Webview/Webview.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class PanelWidget extends StatelessWidget {
  final ScrollController controller;
  final PanelController panelController;
  final String email;
  final String userId;
  const PanelWidget(
      {Key? key, required this.controller, required this.panelController, required this.email, required this.userId})
      : super(key: key);
  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.zero,
      child: Column(children: [
        Icon(
          Icons.keyboard_arrow_up,
          size: 31,
        ),
        BuildIcons(),
        SizedBox(
          height: 30,
        ),
        UserInfo(email: email, userId: userId),
        SizedBox(
          height: 35,
        ),
        BuildMenu(),
        SizedBox(
          height: 100,
        ),
        BuildSignOut(),
      ]),
    );
  }
}

class BuildIcons extends StatelessWidget {
  const BuildIcons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Column(
          children: [
            IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return MainScreen();
                }));
              },
              icon: Image.asset(
                "assets/icons/home.png",
                height: 35,
              ),
            ),
            Text("HOME", style: TextStyle(fontSize: 12))
          ],
        ),
        Column(
          children: [
            IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return MainScreen();
                }));
              },
              icon: Image.asset(
                "assets/icons/edit.png",
                height: 35,
              ),
            ),
            Text("CONTENTS", style: TextStyle(fontSize: 12))
          ],
        ),
        Column(
          children: [
            IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return MainScreen();
                }));
              },
              icon: Image.asset(
                "assets/icons/shopping-bag.png",
                height: 35,
              ),
            ),
            Text("SHOP", style: TextStyle(fontSize: 12)),
          ],
        ),
        Column(
          children: [
            IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return MainScreen();
                }));
              },
              icon: Image.asset(
                "assets/icons/wallet.png",
                height: 35,
              ),
            ),
            Text("WALLET", style: TextStyle(fontSize: 12))
          ],
        ),
        Column(
          children: [
            IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return Webview();
                }));
              },
              icon: Image.asset(
                "assets/icons/pickaxe.png",
                height: 35,
              ),
            ),
            Text(
              "Exchange",
              style: TextStyle(fontSize: 12),
            )
          ],
        ),
      ]),
    );
  }
}

class UserInfo extends StatelessWidget {
  final String email;
  final String userId;
  const UserInfo({Key? key, required this.email, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 110,
        width: double.infinity,
        color: Color(0xff868686),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 35,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                SizedBox(height: 25),
                Text(
                  userId,
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  email,
                  style: TextStyle(color: Colors.white, fontSize: 18),
                )
              ]),
            ],
          ),
        ));
  }
}

class BuildMenu extends StatelessWidget {
  const BuildMenu({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset(
                  "assets/icons/Top.png",
                  height: 25,
                ),
                SizedBox(
                  width: 15,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return BuildTop();
                    }));
                  },
                  style: TextButton.styleFrom(
                    primary: Colors.black,
                    onSurface: Colors.blue,
                    textStyle: TextStyle(fontSize: 24),
                  ),
                  child: Text("Top 100"),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Image.asset(
                  "assets/icons/invite.png",
                  height: 25,
                ),
                SizedBox(
                  width: 15,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return Invite();
                    }));
                  },
                  style: TextButton.styleFrom(
                    primary: Colors.black,
                    onSurface: Colors.blue,
                    textStyle: TextStyle(fontSize: 24),
                  ),
                  child: Text("Invite & Earn"),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(children: [
              Image.asset(
                "assets/icons/notification.png",
                height: 25,
              ),
              SizedBox(
                width: 15,
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return Notifications();
                  }));
                },
                style: TextButton.styleFrom(
                  primary: Colors.black,
                  onSurface: Colors.blue,
                  textStyle: TextStyle(fontSize: 24),
                ),
                child: Text("Notifications"),
              ),
            ]),
            SizedBox(
              height: 10,
            ),
            Row(children: [
              Image.asset(
                "assets/icons/Transaction.png",
                height: 25,
              ),
              SizedBox(
                width: 15,
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return BuildTransaction();
                  }));
                },
                style: TextButton.styleFrom(
                  primary: Colors.black,
                  onSurface: Colors.blue,
                  textStyle: TextStyle(fontSize: 24),
                ),
                child: Text("Mining Transaction"),
              ),
            ]),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Image.asset(
                  "assets/icons/mypage.png",
                  height: 25,
                ),
                SizedBox(
                  width: 15,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return MyPage();
                    }));
                  },
                  style: TextButton.styleFrom(
                    primary: Colors.black,
                    onSurface: Colors.blue,
                    textStyle: TextStyle(fontSize: 24),
                  ),
                  child: Text("My Page"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class BuildSignOut extends StatelessWidget {
  const BuildSignOut({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Row(children: [
          Image.asset(
            "assets/icons/signout.png",
            height: 25,
          ),
          SizedBox(
            width: 15,
          ),
          TextButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return IntroScreen();
              }));
            },
            style: TextButton.styleFrom(
              primary: Colors.black,
              onSurface: Colors.blue,
              textStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            child: Text("Sign Out"),
          ),
        ]),
      ),
    );
  }
}



import 'package:flutter/material.dart';
import 'package:flutter_miningwallet/screens/Invite/invite.dart';
import 'package:flutter_miningwallet/screens/MyPage/MyPage.dart';
import 'package:flutter_miningwallet/screens/Notification/notification.dart';
import 'package:flutter_miningwallet/screens/Top100/BuildTop.dart';
import 'package:flutter_miningwallet/screens/Transaction/Transaction.dart';
import 'package:flutter_miningwallet/screens/introScreen/introScreen.dart';

class SideBar extends StatefulWidget {
  const SideBar({Key? key}) : super(key: key);

  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.grey.shade800,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20),
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(
                "abcabc123",
                style: TextStyle(fontSize: 17, color: Colors.white),
              ),
              accountEmail: Text(
                "aaa@gmail.com",
                style: TextStyle(fontSize: 17, color: Colors.white),
              ),
              decoration: BoxDecoration(color: Colors.grey.shade800),
            ),
            SizedBox(height: 20),
            ListTile(
                tileColor: Colors.green,
                leading: Image.asset(
                  "assets/icons/TopW.png",
                  height: 30,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return BuildTop();
                    }),
                  );
                },
                title: Text(
                  "Top 100",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                )),
            ListTile(
                leading: Image.asset(
                  "assets/icons/InviteW.png",
                  height: 30,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return Invite();
                    }),
                  );
                },
                
                title: Text(
                  "Invite & Earn",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                )),
            ListTile(
                leading: Image.asset(
                  "assets/icons/NotificationsW.png",
                  height: 30,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return Notifications();
                    }),
                  );
                },
                
                title: Text(
                  "Notifications",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                )),
            ListTile(
                leading: Image.asset(
                  "assets/icons/MiningW.png",
                  height: 30,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return BuildTransaction();
                    }),
                  );
                },
                title: Text(
                  "Mining Transaction",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                )),
            ListTile(
                leading: Image.asset(
                  "assets/icons/MypageW.png",
                  height: 30,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return MyPage();
                    }),
                  );
                },
                title: Text(
                  "My Page",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                )),
            SizedBox(
              height: 35,
            ),
            ListTile(
                leading: Image.asset(
                  "assets/icons/SignoutW.png",
                  height: 30,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return IntroScreen();
                    }),
                  );
                },
                title: Text(
                  "Sign Out",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ))
          ],
        ),
      ),
    );
  }
}

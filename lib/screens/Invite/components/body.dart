import 'package:flutter/material.dart';
import 'package:flutter_miningwallet/constants.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 105,
            color: Colors.black,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Image.asset(
                          "assets/icons/left-arrow-key.png",
                          height: 23,
                          color: Colors.white,
                        ),
                        iconSize: 10,
                      ),
                      Text(
                        "Invite & Earn",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          referFriends(),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 348,
                decoration: BoxDecoration(
                  // color: Colors.black,
                    border: Border(bottom:BorderSide(color: Colors.grey, width: 2)),),
                margin: EdgeInsets.symmetric(horizontal: 22),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Text(
                    "My ReFerral",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
          myReferral(),
        ],
      ),
    );
  }
}

Widget referFriends() {
  return Container(
    margin: EdgeInsets.all(22),
    height: 205,
    width: double.infinity,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: Colors.black, width: 1),
    ),
    child: Column(
      children: [
        Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 30, vertical: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Refer Your Friends",
                        style: TextStyle(
                            fontSize: 19, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "on Successful referral\nyou will get 1 GGM",
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 18),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    // color: Colors.black,
                    child: Image.asset(
                      "assets/images/GMClogo.png",
                      height: 92,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {},
                child: Text(
                  "INVITE",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.black,
                  padding: EdgeInsets.symmetric(horizontal: 52, vertical: 13),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                child: Text(
                  "COPY LINK",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                style: ElevatedButton.styleFrom(
                  primary: kPrimaryGrayColor,
                  padding: EdgeInsets.symmetric(horizontal: 37, vertical: 13),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    ),
  );
}

Widget myReferral() {
  return Expanded(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22,),
      child: ListView.separated(
        
        separatorBuilder: (context, index) {
          return Divider(
            color: Colors.grey,
            height: 0,
          );
        },
        itemCount: 50,
        itemBuilder: (_, index) {
          return ListTile(
            leading: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/icons/mypage.png",
                  height: 30,
                ),
              ],
            ),
            title: Text(
              "referyourfrieneds Mavin",
              style: TextStyle(fontSize: 16),
            ),
            trailing: Text("2021-01-01"),
          );
        },
      ),
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:flutter_miningwallet/constants.dart';
import 'package:flutter_miningwallet/repository/CoinRepository.dart';
import 'package:flutter_miningwallet/repository/repository.dart';
import 'package:flutter_miningwallet/screens/MainScreen/mainscreen.dart';
import 'package:flutter_miningwallet/widgets/SideBar/SideBar.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final userRepository = UserRepository();

  List<dynamic> myReferralList = [];
  void initState() {
    userRepository.getStorageUserEmail().then((email) => setState(() {
          userRepository.getMyReferral(email).then((list) => setState(() {
                myReferralList = list;
              }));
        }));
    super.initState();
  }

  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      drawer: SideBar(),
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return MainScreen();
                              }));
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
                      IconButton(
                          onPressed: () {
                            _globalKey.currentState!.openDrawer();
                          },
                          icon: Icon(
                            Icons.menu,
                            size: 30,
                            color: Colors.white,
                          )),
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
                width: 367,
                decoration: BoxDecoration(
                  // color: Colors.black,
                  border:
                      Border(bottom: BorderSide(color: Colors.grey, width: 2)),
                ),
                margin: EdgeInsets.symmetric(horizontal: 22),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    "My ReFerral",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
          myReferral(myReferralList),
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
                        "on Successful referral\nyou will get 1 WBit",
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  // color: Colors.black,
                  child: Image.asset(
                    "assets/images/GMClogo.png",
                    height: 92,
                  ),
                ),
              ],
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

Widget myReferral(List<dynamic> myReferralList) {
  return Expanded(
    child: Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 22,
      ),
      child: ListView.separated(
        separatorBuilder: (context, index) {
          return Divider(
            color: Colors.grey,
            height: 0,
          );
        },
        itemCount: myReferralList.length,
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
              myReferralList[index]["userId"],
              style: TextStyle(fontSize: 16),
            ),
            trailing: Text(myReferralList[index]["createdAt"]),
          );
        },
      ),
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:flutter_miningwallet/screens/MainScreen/components/customTimer.dart';
import 'package:flutter_miningwallet/screens/MyPage/MyPage.dart';
import 'package:flutter_miningwallet/screens/Notification/notification.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  final FlutterSecureStorage storage = FlutterSecureStorage();

  Future<bool> hasValue() async{
    var value = await storage.read(key: 'Value');
    if(value != null){
      return true;
    }else{
      return false;
    }
  }

  String get timerString {
    Duration duration = controller.duration! * controller.value;
    if(hasValue() == true) {
      duration = controller.duration! * controller.value;
    }

    return '${duration.inMinutes}m${(duration.inSeconds % 60).toString().padLeft(2, '0')}s';
  }

  String email = "";

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: Duration(seconds: 10/*minutes: 1*/));
    _getEmail().then((val) => setState(() {
      email = val.toString();
    }));
  }


  Future<String> _getEmail() async{
    final FlutterSecureStorage storage = FlutterSecureStorage();
    return await storage.read(key: "User");
  }

  @override
  Widget build(BuildContext context) {

    var animation = CurvedAnimation(parent: controller, curve: Curves.bounceInOut);
    animation.addStatusListener((status) {
      print(controller.value);
      if (status == AnimationStatus.dismissed) {
        //controller.forward();
        print("dismissed!!!!!!!!!");
      }
    });

    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 15,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
            height: 50,
            // color: Colors.black,
            child: Row(
              children: [
                Text(
                  "GGM",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  "Coin Faucent",
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  width: 79,
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return Notifications();
                        },
                      ),
                    );
                  },
                  icon: Image.asset("assets/icons/notification.png"),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return MyPage();
                        },
                      ),
                    );
                  },
                  icon: Image.asset(
                    "assets/icons/mypage.png",
                    height: 35,
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              children: [
                making(),
                SizedBox(
                  height: 30,
                ),
                countdowntimer(),
                SizedBox(
                  height: 20,
                ),
                useractive(email),
                SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    claimed(),
                    referral(),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                gmcusd(),
                SizedBox(
                  height: 15,
                ),
                totalUser(),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget making() {
    return Container(
      width: double.infinity,
      height: 65,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.black,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 21),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "My Making",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            Text("0.0500000",
                style: TextStyle(color: Colors.white, fontSize: 20)),
          ],
        ),
      ),
    );
  }

  Widget countdowntimer() {
    return AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          return CustomPaint(
            foregroundPainter: CustomTimerPainter(animation: controller),
            child: Container(
              width: 200,
              height: 200,
              // color: Colors.black,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Claim GGM",
                    style: TextStyle(fontSize: 23),
                  ),
                  Text(
                    timerString,
                    style: TextStyle(fontSize: 23),
                  )
                ],
              ),
            ),
          );
        });
  }

  Widget useractive(String email) {
    return Container(
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Image.asset(
              "assets/icons/user.png",
              height: 32,
            ),
          ),
          SizedBox(
            width: 7,
          ),
          Text(
            email,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              AnimatedBuilder(
                  animation: controller,
                  builder: (context, child) {
                    return OutlinedButton(
                      onPressed: () {
                        if (controller.isAnimating)
                          controller.stop();
                        else {
                          // controller.forward();
                          controller.reverse(
                              from: controller.value == 0.0
                                  ? 1.0
                                  : controller.value);

                        }
                      },
                      style: OutlinedButton.styleFrom(
                          primary: Colors.black,
                          side: BorderSide(color: Colors.black),
                          padding: EdgeInsets.all(7)),
                      child: Text(
                        controller.isAnimating ? "STOP" : "ACTIVE",
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    );
                  }),
            ]),
          ),
        ],
      ),
    );
  }

  Widget claimed() {
    return Container(
      height: 72,
      width: 160,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(children: [
        Padding(
          padding: const EdgeInsets.only(left: 15, top: 13, bottom: 13),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Claimed",
                  style: TextStyle(color: Colors.white, fontSize: 14)),
              SizedBox(height: 9),
              Text("0.05000000",
                  style: TextStyle(color: Colors.white, fontSize: 18)),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
          child: Column(
            children: [
              Image.asset(
                "assets/icons/pickaxe.png",
                height: 20,
                color: Colors.white,
              ),
            ],
          ),
        )
      ]),
    );
  }

  Widget referral() {
    return Container(
      height: 72,
      width: 160,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(children: [
        Padding(
          padding: const EdgeInsets.only(left: 15, top: 13, bottom: 13),
          child: Container(
            // color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Referral",
                    style: TextStyle(color: Colors.white, fontSize: 14)),
                SizedBox(height: 9),
                Text("0.00000000",
                    style: TextStyle(color: Colors.white, fontSize: 18)),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 10),
          child: Column(
            children: [
              Icon(
                Icons.person_add,
                color: Colors.white,
                size: 28,
              ),
            ],
          ),
        )
      ]),
    );
  }

  Widget gmcusd() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(10),
      ),
      height: 72,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "GGM │ USD",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            Text(
              "0.0500000",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }

  Widget totalUser() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(10),
      ),
      height: 72,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Total Users",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            Text(
              "64.565",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}

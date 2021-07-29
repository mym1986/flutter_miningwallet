import 'package:flutter/material.dart';
import 'package:flutter_miningwallet/repository/CoinRepository.dart';
import 'package:flutter_miningwallet/screens/MainScreen/components/customTimer.dart';
import 'package:flutter_miningwallet/screens/MyPage/MyPage.dart';
import 'package:flutter_miningwallet/screens/Notification/notification.dart';
import 'package:flutter_miningwallet/widgets/SideBar/SideBar.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../mainscreen.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  final _coinRepository = CoinRepository();

  String get timerString {
    Duration duration = controller.duration! * controller.value;
    return '${duration.inMinutes}m${(duration.inSeconds % 60).toString().padLeft(2, '0')}s';
  }

  String email = "";
  double value = 1.0;
  bool isMining = false;
  double myValue = 0.0;
  int todayCount = 0;
  double todayAmount = 0.0;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this, duration: Duration(/*seconds: 10*/ minutes: 10));
    _getEmail().then((val) => setState(() {
          email = val.toString();
          _coinRepository
              .getMining(val.toString(), 0.05)
              .then((result) => setState(() {
                    if (double.parse(result["miningValue"]) > 0) {
                      value = double.parse(result["miningValue"]);
                    }
                    if (double.parse(result["amount"]) > 0) {
                      myValue = double.parse(result["amount"]);
                    }
                    if (int.parse(result["todayCount"]) > 0) {
                      todayCount = int.parse(result["todayCount"]);
                    }
                    if (double.parse(result["todayAmount"]) > 0) {
                      todayAmount = double.parse(result["todayAmount"]);
                    }
                    controller.reverse(from: 1 - value);
                    // controller.value = 1 - value;
                  }));
        }));
  }

  Future<String> _getEmail() async {
    final FlutterSecureStorage storage = FlutterSecureStorage();
    return await storage.read(key: "User");
  }

  Future<bool> _startMining() async {
    Map resultMap = await _coinRepository.updateMining(email, 0.05);
    myValue = resultMap["value"];
    return true;
  }

  Future<bool> _getMining() async {
    Map resultMap = await _coinRepository.getMining(email, 0.05);
    myValue = resultMap["value"];
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return MainScreen();
    }));
    return true;
  }

  Future<void> _setStatus() async {
    //await _coinRepository.getMining(email, 0.05);
  }
  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    var animation =
        CurvedAnimation(parent: controller, curve: Curves.bounceInOut);
    animation.addStatusListener((status) async {
      print("status : " + status.toString());
      print("controller.value : " + controller.value.toString());
      if (status == AnimationStatus.completed) {
        await _startMining();
      } else if (status == AnimationStatus.dismissed) {
        await _getMining();
      }
    });

    return Scaffold(
      key: _globalKey,
      drawer: SideBar(),
      body: Column(
        children: [
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 12, vertical: 13),
              height: 50,
              // color: Colors.black,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Row(
                      children: [
                        Text(
                          "WBit",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Coin Faucent",
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      children: [
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
                              _globalKey.currentState!.openDrawer();
                            },
                            icon: Icon(Icons.menu, size: 30)),
                      ],
                    ),
                  ),
                ],
              ),
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
              "My Making(" + todayCount.toString() + "/10)",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            Text(todayAmount.toString(),
                style: TextStyle(color: Colors.white, fontSize: 20)),
          ],
        ),
      ),
    );
  }

  Widget countdowntimer() {
    return
        // GestureDetector(
        //   onTap: () {
        //     if (!controller.isAnimating && todayCount < 10) {
        //       controller.reverse(
        //           from: controller.value == 0.0 ? 1.0 : controller.value);
        //     }
        //   },
        // child:
        AnimatedBuilder(
            animation: controller,
            builder: (context, child) {
              return CustomPaint(
                foregroundPainter: CustomTimerPainter(animation: controller),
                child: Container(
                  width: 210,
                  height: 210,
                  // color: Colors.black,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/icons/mining.png",
                        height: 80,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.black, onPrimary: Colors.white),
                        onPressed: () {
                          if (!controller.isAnimating && todayCount < 10) {
                            controller.reverse(
                                from: controller.value == 0.0
                                    ? 1.0
                                    : controller.value);
                          }
                        },
                        child: Text(
                            controller.isAnimating
                                ? timerString
                                : "Mining Start",
                            style:
                                TextStyle(color: Colors.white, fontSize: 18)),
                      ),
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
                    return Container(
                      height: 40,
                      width: 70,
                      decoration: BoxDecoration(
                          color: controller.isAnimating
                              ? Colors.black
                              : Colors.red.shade600,
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: Text(
                          controller.isAnimating ? "ACTIVE" : "STOP",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                    // OutlinedButton(
                    //   onPressed: () {
                    //     if (!controller.isAnimating && todayCount < 10) {
                    //       controller.reverse(
                    //           from: controller.value == 0.0
                    //               ? 1.0
                    //               : controller.value);
                    //     }
                    //   },
                    //   style: OutlinedButton.styleFrom(
                    //       primary: Colors.black,
                    //       side: BorderSide(color: Colors.black),
                    //       padding: EdgeInsets.all(7)),
                    //   child: Text(
                    //     "ACTIVE",
                    //     // controller.isAnimating ? "ACTIVE" : "STOP",
                    //     style: TextStyle(fontSize: 16, color: Colors.black),
                    //   ),
                    // );
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
              Text(myValue.toString(),
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
                Text("0.00",
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
              "WBit │ USD",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            Text(
              "0.05",
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
              "12,562",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}

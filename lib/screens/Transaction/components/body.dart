import 'package:flutter/material.dart';
import 'package:flutter_miningwallet/screens/MainScreen/mainscreen.dart';
import 'package:flutter_miningwallet/widgets/SideBar/SideBar.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

DateTime now = DateTime.now();
DateTime currentTime =
    new DateTime(now.year, now.month, now.day, now.hour, now.minute);

class _BodyState extends State<Body> {
  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      drawer: SideBar(),
      body: Column(children: [
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
                          "Mining Transaction",
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
        Container(
          decoration: BoxDecoration(
            // color: Colors.black,
            border: Border(bottom: BorderSide(color: Colors.grey, width: 2)),
          ),
          margin: EdgeInsets.symmetric(horizontal: 23),
          child: Row(
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
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Text(
                    "My Mining Transaction",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: buildTopListView(),
            ),
          ),
        ),
      ]),
    );
  }
}

Widget buildTopListView() {
  return ListView.separated(
      padding: EdgeInsets.all(0),
      separatorBuilder: (context, index) {
        return Divider(
          color: Colors.grey,
          height: 0,
        );
      },
      itemCount: 100,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          leading:
              Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              "$currentTime",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(
              width: 30,
            ),
          ]),
          title: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  "WBit",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                  ),
                ),
              )
            ],
          ),
          trailing: Text(
            "0.05",
            style: TextStyle(fontSize: 17),
          ),
        );
      });
}

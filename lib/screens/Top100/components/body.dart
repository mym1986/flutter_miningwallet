import 'package:flutter/material.dart';
import 'package:flutter_miningwallet/repository/CoinRepository.dart';
import 'package:flutter_miningwallet/screens/MainScreen/mainscreen.dart';
import 'package:flutter_miningwallet/widgets/SideBar/SideBar.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final coinRepository = CoinRepository();
  List<dynamic> top100 = [];
  void initState() {
    coinRepository.getTop100().then((list) => setState(() {
          top100 = list;
        }));
    super.initState();
  }

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
                          "Top 100",
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
        Expanded(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: buildTopListView(top100),
            ),
          ),
        ),
      ]),
    );
  }
}

Widget buildTopListView(List<dynamic> top100) {
  return ListView.separated(
      padding: EdgeInsets.all(0),
      separatorBuilder: (context, index) {
        return Divider(
          color: Colors.grey,
          height: 0,
        );
      },
      itemCount: top100.length,
      itemBuilder: (_, index) {
        return ListTile(
          leading:
              Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              "${index + 1}",
              style: TextStyle(fontSize: 23),
            ),
            SizedBox(
              width: 30,
            ),
          ]),
          title: Row(
            children: [
              Text(
                top100[index]["email"],
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
          subtitle: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                top100[index]["amount"].toStringAsFixed(2),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 10),
              //   child: Text(
              //     "GMC",
              //     style: TextStyle(
              //       color: Colors.black,
              //       fontSize: 15,
              //       fontWeight: FontWeight.bold,
              //     ),
              //   ),
              // ),
            ],
          ),
          trailing: Image.asset(
            "assets/icons/user.png",
            height: 35,
          ),
        );
      });
}

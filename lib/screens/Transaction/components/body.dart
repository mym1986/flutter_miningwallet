import 'package:flutter/material.dart';
import 'package:flutter_miningwallet/repository/CoinRepository.dart';
import 'package:flutter_miningwallet/screens/MainScreen/mainscreen.dart';
import 'package:flutter_miningwallet/widgets/SideBar/SideBar.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

DateTime now = DateTime.now();
String formattedDate = DateFormat('yyyy-MM-dd  kk:mm').format(now);

class _BodyState extends State<Body> {
  final coinRepository = CoinRepository();
  List<dynamic> miningHistory = [];
  void initState() {
    _getEmail().then((val) => setState(() {
      coinRepository.getMiningHistory(val.toString()).then((list) => setState(() {
        miningHistory = list;
      }));
    }));
    super.initState();
  }

  Future<String?> _getEmail() async {
    final FlutterSecureStorage storage = FlutterSecureStorage();
    return await storage.read(key: "User");
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
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Text(
                  "My Mining Transaction",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: buildTopListView(miningHistory),
            ),
          ),
        ),
      ]),
    );
  }
}

Widget buildTopListView(List<dynamic> miningHistory) {
  return ListView.separated(
      padding: EdgeInsets.all(0),
      separatorBuilder: (context, index) {
        return Divider(
          color: Colors.grey,
          height: 0,
        );
      },
      itemCount: miningHistory.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          leading:
              Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              miningHistory[index]["miningStartDt"]["year"].toString() + "-" +
              (miningHistory[index]["miningStartDt"]["monthValue"].toString().length == 1? "0": "") +
              miningHistory[index]["miningStartDt"]["monthValue"].toString()+ "-" +
              (miningHistory[index]["miningStartDt"]["dayOfMonth"].toString().length == 1? "0": "") +
              miningHistory[index]["miningStartDt"]["dayOfMonth"].toString() + " " +
              (miningHistory[index]["miningStartDt"]["hour"].toString().length == 1? "0": "") +
              miningHistory[index]["miningStartDt"]["hour"].toString() + ":" +
              (miningHistory[index]["miningStartDt"]["minute"].toString().length == 1? "0": "") +
              miningHistory[index]["miningStartDt"]["minute"].toString() + ":" +
              (miningHistory[index]["miningStartDt"]["second"].toString().length == 1? "0": "") +
              miningHistory[index]["miningStartDt"]["second"].toString(),
              // "$formattedDate",
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
            miningHistory[index]["miningAmount"].toString(),
            style: TextStyle(fontSize: 17),
          ),
        );
      });
}

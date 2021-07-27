import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

DateTime now = DateTime.now();
DateTime currentTime =
    new DateTime(now.year, now.month, now.day, now.hour, now.minute);

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      "Mining Transaction",
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
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 348,
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
              style: TextStyle(fontSize: 23),
            ),
            SizedBox(
              width: 30,
            ),
          ]),
          title: Row(
            children: [
              Text(
                "Nik Iv",
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
                "708.55000000",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  "GMC",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          trailing: Image.asset(
            "assets/icons/user.png",
            height: 35,
          ),
        );
      });
}

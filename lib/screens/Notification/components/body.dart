import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

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
                      "Notifications",
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
        Expanded(
          child: buildNotificationListView(),
        ),
      ]),
    );
  }
}

Widget buildNotificationListView() {
  return ListView.builder(
      padding: EdgeInsets.only(top: 5),
      itemCount: 20,
      itemBuilder: (context, a) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
          child: ourData(),
        );
      });
}

Widget ourData() {
  return Container(
    height: 150,
    margin: EdgeInsets.only(top: 10, left: 20, right: 20),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20), color: Color(0xff6C6C72)),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Welcome Korea WBit",
            style: TextStyle(
                fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 14,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "2021-05-05 11:55am",
                style: TextStyle(fontSize: 15, color: Colors.white),
              ),
            ],
          ),
          SizedBox(
            height: 14,
          ),
          Text(
            "Congrations on creation your GMC Coin Faucet - No Mining account. You've just joined the community of Faucets.",
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
        ],
      ),
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:flutter_miningwallet/screens/membership/components/body.dart';

class BuildMembership extends StatefulWidget {
  final String email;

  const BuildMembership({Key? key, required this.email}) : super(key: key);

  @override
  _BuildMembershipState createState() => _BuildMembershipState();
}
bool _checkConfiguration() => true;

class _BuildMembershipState extends State<BuildMembership> {

  @override
  void initState() {
    super.initState();
    if (_checkConfiguration()) {
      Future.delayed(Duration.zero, () {
        _buildAlert(context);
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.black,
        body: Column(
          children: [
            Container(
              color: Colors.black,
              height: 133,
              width: double.infinity,
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height:35),
                    Text(
                      "FREE MEMBERSHIP",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Body(email: widget.email),
          ],
        ));
  }
}

Future<void> _buildAlert(BuildContext context) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        title: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            "Notification",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
          ),
        ]),
        content: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            "If you register your recommender ID,\nyou will receive WBit-Coin (5Coin)\nfor free.",
            style: TextStyle(fontSize: 17),
          ),
        ]),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height:40,
                width: 130,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      primary: Colors.black,
                      onPrimary: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Check',
                      style: TextStyle(color: Colors.white, fontSize: 22),
                    )),
              ),
            ],
          ),
        ],
      );
    },
  );
}
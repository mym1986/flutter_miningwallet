import 'package:flutter/material.dart';
import 'package:flutter_miningwallet/screens/membership/components/body.dart';

class BuildMembership extends StatefulWidget {
  final String email;

  const BuildMembership({Key? key, required this.email}) : super(key: key);

  @override
  _BuildMembershipState createState() => _BuildMembershipState();
}

class _BuildMembershipState extends State<BuildMembership> {
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

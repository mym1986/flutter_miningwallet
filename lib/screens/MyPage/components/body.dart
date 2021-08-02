import 'package:flutter/material.dart';
import 'package:flutter_miningwallet/repository/repository.dart';
import 'package:flutter_miningwallet/screens/MainScreen/mainscreen.dart';
import 'package:flutter_miningwallet/widgets/SideBar/SideBar.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../MyPage.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final userRepository = UserRepository();
  final _phoneController1 = TextEditingController();
  final _phoneController2 = TextEditingController();
  final _phoneController3 = TextEditingController();
  final _pinController = TextEditingController();
  String _email = "";
  String _userId = "";
  String _recommender = "";
  void initState() {
    userRepository.getStorageUserEmail().then((email) => setState(() {
          userRepository.getUser(email!).then((map) => setState(() {
                _email = map["email"];
                _userId = map["userId"];
                _recommender = map["recommender"];
                List<String> phone = map["phone"].split("-");
                for (int i = 0; i < phone.length; i++) {
                  switch (i) {
                    case 0:
                      _phoneController1.text = phone[0];
                      break;
                    case 1:
                      _phoneController2.text = phone[1];
                      break;
                    case 2:
                      _phoneController3.text = phone[2];
                      break;
                  }
                }
                _pinController.text = map["pin"];
              }));
        }));
    super.initState();
  }

  _onSignUpButtonPressed(String email, String mobile1, String mobile2,
      String mobile3, String pin) async {
    if (pin == '') {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: Duration(seconds: 2),
        content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text("PIN을 입력하세요.", style: TextStyle(fontSize: 18))]),
        backgroundColor: Colors.red,
      ));
      // _passwordController.text = "";
    } else if (mobile1 == '' || mobile2 == '' || mobile3 == '') {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: Duration(seconds: 2),
        content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text("휴대폰번호를 입력하세요.", style: TextStyle(fontSize: 18))]),
        backgroundColor: Colors.red,
      ));
    } else {
      String phone = mobile1 + "-" + mobile2 + "-" + mobile3;

      final String user = await userRepository.updateUser(email, phone, pin);
      if (user == email) {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return MyPage();
        }));
      }
    }
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
                          "My Page",
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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                photo(),
                SizedBox(
                  height: 15,
                ),
                email(_email),
                SizedBox(
                  height: 15,
                ),
                phonenumber(
                    _phoneController1, _phoneController2, _phoneController3),
                SizedBox(
                  height: 15,
                ),
                id(_userId),
                SizedBox(
                  height: 15,
                ),
                input(_pinController),
                SizedBox(
                  height: 15,
                ),
                recommender(_recommender),
                SizedBox(
                  height: 13,
                ),
                modifyButton(_onSignUpButtonPressed, _email, _phoneController1,
                    _phoneController2, _phoneController3, _pinController)
              ],
            ),
          ),
        )
      ]),
    );
  }
}

Widget photo() {
  return Column(children: [
    Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Text(
          "PHOTO",
          style: TextStyle(
              color: Colors.grey, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    ]),
    SizedBox(
      height: 5,
    ),
    Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: ClipOval(
            child: Image.asset(
              "assets/icons/user.png",
              height: 50,
            ),
          ),
        ),
      ],
    )
  ]);
}

Widget email(String _email) {
  return Column(
    children: [
      Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            "E-mail",
            style: TextStyle(
                color: Colors.grey, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ]),
      Container(
        height: 55,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey.withOpacity(0.4),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                _email,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
          ],
        ),
      )
    ],
  );
}

Widget phonenumber(
    TextEditingController _phoneController1,
    TextEditingController _phoneController2,
    TextEditingController _phoneController3) {
  return Column(children: [
    Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Text(
          "Mobile",
          style: TextStyle(
              color: Colors.grey, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    ]),
    SizedBox(
      height: 5,
    ),
    Row(
      children: [
        Container(
          width: 95,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextFormField(
            controller: _phoneController1,
            style: TextStyle(color: Colors.black, fontSize: 16),
            decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 32, vertical: 15),
                //hintText: '010',
                hintStyle: TextStyle(fontWeight: FontWeight.bold),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey.withOpacity(0.5)),
                ),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        BorderSide(color: Colors.grey.withOpacity(0.5)))),
          ),
        ),
        Text(" ― "),
        Container(
          width: 105,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextFormField(
            controller: _phoneController2,
            style: TextStyle(color: Colors.black, fontSize: 16),
            decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 34, vertical: 16),
                //hintText: '7777',
                hintStyle: TextStyle(fontWeight: FontWeight.bold),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey.withOpacity(0.5)),
                ),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        BorderSide(color: Colors.grey.withOpacity(0.5)))),
          ),
        ),
        Text(" ― "),
        Container(
          width: 105,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextFormField(
            controller: _phoneController3,
            style: TextStyle(color: Colors.black, fontSize: 16),
            decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 34, vertical: 16),
                //hintText: '7777',
                hintStyle: TextStyle(fontWeight: FontWeight.bold),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey.withOpacity(0.5)),
                ),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        BorderSide(color: Colors.grey.withOpacity(0.5)))),
          ),
        ),
      ],
    )
  ]);
}

Widget id(String _userId) {
  return Column(
    children: [
      Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            "ID",
            style: TextStyle(
                color: Colors.grey, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ]),
      Container(
        height: 55,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey.withOpacity(0.4),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                _userId,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
          ],
        ),
      )
    ],
  );
}

Widget input(TextEditingController _pinController) {
  return Column(children: [
    Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            "PIN",
            style: TextStyle(
                color: Colors.grey, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    ),
    Container(
      height: 55,
      child: TextFormField(
        controller: _pinController,
        style: TextStyle(color: Colors.black, fontSize: 18),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 18),
            //hintText: '123456',
            hintStyle: TextStyle(fontWeight: FontWeight.bold),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.grey.withOpacity(0.5)),
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.grey.withOpacity(0.5)))),
      ),
    ),
  ]);
}

Widget recommender(String _recommender) {
  return Column(
    children: [
      Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            "recommender",
            style: TextStyle(
                color: Colors.grey, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ]),
      Container(
        height: 55,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey.withOpacity(0.4),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                _recommender,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
          ],
        ),
      )
    ],
  );
}

Widget modifyButton(
    Function _onSignUpButtonPressed,
    String email,
    TextEditingController _phoneController1,
    TextEditingController _phoneController2,
    TextEditingController _phoneController3,
    TextEditingController _pinController) {
  return ElevatedButton(
    onPressed: () {
      _onSignUpButtonPressed(email, _phoneController1.text,
          _phoneController2.text, _phoneController3.text, _pinController.text);
      // Navigator.push(context, MaterialPageRoute(builder: (context) {
      //   return MainScreen();
      // }));
    },
    style: ElevatedButton.styleFrom(
        primary: Colors.black,
        onPrimary: Colors.white,
        minimumSize: Size(400, 55),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
    child: Text(
      "Modify",
      style: TextStyle(color: Colors.white, fontSize: 20),
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:flutter_miningwallet/repository/repository.dart';
import 'package:flutter_miningwallet/screens/MainScreen/mainscreen.dart';

class Body extends StatefulWidget {
  final String email;
  const Body({Key? key, required this.email}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _mobileController1 = TextEditingController();
  final _mobileController2 = TextEditingController();
  final _mobileController3 = TextEditingController();
  final _idController = TextEditingController();
  final _pinController = TextEditingController();
  final _recommenderController = TextEditingController();
  final _userRepository = UserRepository();

  _onSignUpButtonPressed(String email, String mobile1, String mobile2, String mobile3, String id, String pin, String recommender) async {

    print(email);
    print(mobile1);
    print(mobile2);
    print(mobile3);
    print(id);
    print(pin);
    print(recommender);

    if (pin == '') {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: Duration(seconds: 2),
        content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text("PIN을 입력하세요.", style: TextStyle(fontSize: 18))]),
        backgroundColor: Colors.red,
      ));
      // _passwordController.text = "";
    } else if (id == '') {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: Duration(seconds: 2),
        content: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text("id를 입력하세요.", style: TextStyle(fontSize: 18))
        ]),
        backgroundColor: Colors.red,
      ));

      // _passwordController2.text = "";
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

      final String user = await _userRepository.signUp(email, "", phone, "", pin, recommender, id);
      if(user == email) {
        _userRepository.persisteUser(email);
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return MainScreen();
        }));
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: double.infinity,
        height: 20,
        // color: Colors.green,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0))),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Container(
            child: Column(
              children: <Widget>[
                SizedBox(height: 40),
                email(widget.email),
                SizedBox(height: 20),
                phonenumber(_mobileController1, _mobileController2, _mobileController3),
                SizedBox(height: 20),
                input(_idController, _pinController, _recommenderController),
                SizedBox(height: 50),
                inviteButton(_onSignUpButtonPressed, widget.email,  _mobileController1, _mobileController2, _mobileController3, _idController, _pinController, _recommenderController),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget email(String email) {
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
                email,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
          ],
        ),
      )
    ],
  );
}

Widget phonenumber(TextEditingController _mobileController1, TextEditingController _mobileController2, TextEditingController _mobileController3) {
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
            controller: _mobileController1,
            style: TextStyle(color: Colors.black, fontSize: 16),
            decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 32, vertical: 15),
                hintText: '010',
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
            controller: _mobileController2,
            style: TextStyle(color: Colors.black, fontSize: 16),
            decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 34, vertical: 16),
                hintText: '7777',
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
            controller: _mobileController3,
            style: TextStyle(color: Colors.black, fontSize: 16),
            decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 34, vertical: 16),
                hintText: '7777',
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

Widget input(TextEditingController _idController, TextEditingController _pinController, TextEditingController _recommenderController) {
  return Column(children: [
    Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            "ID",
            style: TextStyle(
                color: Colors.grey, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    ),
    Container(
      height: 55,
      child: TextFormField(
        controller: _idController,
        style: TextStyle(color: Colors.black, fontSize: 18),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 18),
            hintText: 'abcabc111',
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
    SizedBox(
      height: 12,
    ),
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
        controller : _pinController,
        style: TextStyle(color: Colors.black, fontSize: 18),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 18),
            hintText: '123456',
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
    SizedBox(
      height: 12,
    ),
    Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            "Recommender",
            style: TextStyle(
                color: Colors.grey, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    ),
    Container(
      height: 55,
      child: TextFormField(
        controller : _recommenderController,
        style: TextStyle(color: Colors.black, fontSize: 18),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 18),
            hintText: 'gmcadmin',
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

Widget inviteButton(Function _onSignUpButtonPressed, email,
    TextEditingController _mobileController1, TextEditingController _mobileController2, TextEditingController _mobileController3,
    TextEditingController _idController, TextEditingController _pinController, TextEditingController _recommenderController) {
  return ElevatedButton(
    onPressed: () {
      // _onSignUpButtonPressed(String email, String mobile1, String mobile2, String mobile3, String id, String pin, String recommender) {

      onPressed: _onSignUpButtonPressed(email, _mobileController1.text, _mobileController2.text, _mobileController3.text
          ,_idController.text, _pinController.text, _recommenderController.text);


      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) {
      //       return MainScreen();
      //     },
      //   ),
      // );
    },
    style: ElevatedButton.styleFrom(
        primary: Colors.black,
        onPrimary: Colors.white,
        minimumSize: Size(400, 55),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
    child: Text(
      "INVITE",
      style: TextStyle(color: Colors.white, fontSize: 20),
    ),
  );
}



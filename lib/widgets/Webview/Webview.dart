import 'package:flutter/material.dart';
import 'package:flutter_miningwallet/screens/MainScreen/mainscreen.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewPage extends StatefulWidget {
  const WebviewPage({Key? key}) : super(key: key);

  @override
  _WebviewPageState createState() => _WebviewPageState();
}

class _WebviewPageState extends State<WebviewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebView(
        initialUrl: "https://m.naver.com",
        javascriptMode: JavascriptMode.unrestricted,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return MainScreen();
            }),
          );
        },
        child: Icon(
          Icons.home,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }
}

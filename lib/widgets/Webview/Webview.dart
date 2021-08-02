import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Webview extends StatefulWidget {
  const Webview({Key? key}) : super(key: key);

  @override
  _WebviewState createState() => _WebviewState();
}

late final Future<WebViewController> _webViewControllerFuture;

class _WebviewState extends State<Webview> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(body: 
        WebView(
          initialUrl: "https://m.naver.com",
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
        ),
        bottomNavigationBar: FutureBuilder(
          future: _controller.future,
          builder: (BuildContext context,
              AsyncSnapshot<WebViewController> snapshot) {
            final bool webViewReady =
                snapshot.connectionState == ConnectionState.done;
            final WebViewController? controller = snapshot.data;
            return Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: Container(
                color: Colors.grey,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: Icon(Icons.home), // 홈 페이지 가기.
                      onPressed: () {
                        controller!.loadUrl('https://m.naver.com');
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.navigate_before, // 전 페이지 가기.
                        size: 30,
                      ),
                      onPressed: !webViewReady
                          ? null
                          : () async {
                              if (await controller!.canGoBack()) {
                                await controller.goBack();
                              } else {
                               
                              }
                            },
                    ),
                    IconButton(
                      icon: Icon(Icons.navigate_next, size: 30), // 앞 페이지 가기.
                      onPressed: !webViewReady
                          ? null
                          : () async {
                              if (await controller!.canGoForward()) {
                                await controller.goForward();
                              } else {
                                
                              }
                            },
                    ),
                    IconButton(
                      icon: Image.asset("assets/icons/miningBlack.png",height: 21,),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

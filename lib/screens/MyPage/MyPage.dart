import 'package:flutter/material.dart';
import 'package:flutter_miningwallet/screens/MyPage/components/body.dart';
import 'package:flutter_miningwallet/widgets/Panel_widget/Panelbody.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class MyPage extends StatefulWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  final panelController = PanelController();

  @override
  Widget build(BuildContext context) {
    final panelHeightOpen = MediaQuery.of(context).size.height * 0.93;
    final panelHeightClosed = MediaQuery.of(context).size.height * 0.12;

    return Scaffold(
      body: SlidingUpPanel(
        controller: panelController,
        panelBuilder: (controller) => PanelWidget(
            controller: controller, panelController: panelController),
        maxHeight: panelHeightOpen,
        minHeight: panelHeightClosed,
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
        boxShadow: [
          BoxShadow(
              color: Colors.grey,
              blurRadius: 4,
              spreadRadius: 9,
              offset: Offset(1, 8)),
        ],
        body: Body(),
      ),
    );
  }
}

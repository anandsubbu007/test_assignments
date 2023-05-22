// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:lionsbot_test/component/joystick/joy_stick_handle.dart';
import 'package:lionsbot_test/screen/remote/component/action_button.dart';
import 'package:lionsbot_test/screen/remote/component/bottom_bar.dart';
import 'package:lionsbot_test/screen/remote/component/top_actions.dart';

class RemoteControllScreen extends StatefulWidget {
  @override
  _RemoteControllScreenState createState() => _RemoteControllScreenState();
}

class _RemoteControllScreenState extends State<RemoteControllScreen> {
  bool isStrated = false;

  Widget renderSpace(double value) {
    return SizedBox(height: value);
  }

  renderVerticalLine(double height, EdgeInsets edge) {
    return Column(mainAxisAlignment: MainAxisAlignment.end, children: [
      Container(
          padding: EdgeInsets.all(5),
          width: 1.5,
          height: height,
          margin: edge,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
          ))
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
          leading: TextButton(
            onPressed: () => Navigator.pop(context),
            child: Icon(Icons.arrow_back,
                color: Color.fromARGB(255, 250, 250, 252)),
          ),
          backgroundColor: Colors.transparent,
          title: const Text('Remote Control'),
          elevation: 0),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment(0.8, 1),
          colors: [Colors.blue, Colors.red, Colors.white],
        )),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                renderSpace(110),
                TopSwitches(),
                renderSpace(50),
                Expanded(child: JoyStickHandle()),
                ActionButtom(),
                renderSpace(90),
              ],
            ),
            SettingBottomOption(),
          ],
        ),
      ),
    );
  }
}

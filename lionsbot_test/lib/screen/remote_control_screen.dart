// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

import '../component/custom_scroll_view.dart';
import '../component/custom_switch.dart';
import '../component/joystick_view.dart';

class RemoteControllScreen extends StatefulWidget {
  @override
  _RemoteControllScreenState createState() => _RemoteControllScreenState();
}

class _RemoteControllScreenState extends State<RemoteControllScreen> {
  bool isWaterEnabled = false;
  bool isBrushEnabled = false;
  bool isStrated = false;

  Padding renderSpace(double value) {
    return Padding(padding: EdgeInsets.all(value));
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
            onPressed: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back,
                color: Color.fromARGB(255, 250, 250, 252)),
          ),
          backgroundColor: Colors.transparent,
          title: const Text('Remote Control'),
          elevation: 0.0,
        ),
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment(0.8, 1),
            colors: [
              Colors.blue,
              Colors.red,
              Colors.white,
            ],
          )),
          child: Stack(alignment: Alignment.topCenter, children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                renderSpace(50),
                Expanded(
                    child: Divider(
                  color: Colors.white,
                )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CutomSwitch(
                      label: "WATER",
                      value: isWaterEnabled,
                      icon: Icons.water_drop_outlined,
                      onChanged: (value) {
                        setState(() {
                          isWaterEnabled = value;
                        });
                      },
                    ),
                    renderVerticalLine(40, EdgeInsets.all(10)),
                    CutomSwitch(
                      label: "BRUSH",
                      value: isBrushEnabled,
                      icon: Icons.wifi_tethering,
                      onChanged: (value) {
                        setState(() {
                          isBrushEnabled = value;
                        });
                      },
                    ),
                  ],
                ),
                Expanded(
                    child: Divider(
                  color: Colors.white,
                )),
                renderSpace(50),
                JoystickView(
                  opacity: 1,
                  size: 200,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 100, bottom: 0),
                  child: SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: isStrated ? Colors.red : Colors.blue,
                          alignment: Alignment.center,
                          textStyle: const TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold)),
                      onPressed: () {
                        // authController.login();
                        setState(() {
                          isStrated = !isStrated;
                        });
                      },
                      child: Row(
                        children: <Widget>[
                          Spacer(),
                          Text(
                            isStrated ? "STOP" : "START",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          Spacer(),
                        ],
                      ),
                    ),
                  ),
                ),
                renderSpace(200)
              ],
            ),
            DraggableScrollableSheet(
              initialChildSize: 0.15,
              minChildSize: 0.15,
              builder:
                  (BuildContext context, ScrollController scrollController) {
                return SingleChildScrollView(
                  controller: scrollController,
                  child: CustomScrollViewContent(),
                );
              },
            ),
          ]),
        ));
  }
}

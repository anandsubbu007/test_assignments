// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors

import 'package:flutter/material.dart';

import 'custom_dragging_handle.dart';

class CustomInnerContent extends StatefulWidget {
  const CustomInnerContent({super.key});

  @override
  _CustomInnerContentState createState() => _CustomInnerContentState();
}

class _CustomInnerContentState extends State<CustomInnerContent> {
  double _currentSliderValue = 10;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: 12),
        CustomDraggingHandle(),
        SizedBox(height: 12),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.settings,
              size: 25,
              color: Colors.white,
            ),
            SizedBox(height: 12),
            Text("settings",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
            SizedBox(height: 20),
            Row(children: [
              Padding(
                  padding: EdgeInsets.fromLTRB(30, 30, 0, 0),
                  child: Text(
                      "Speed : ${_currentSliderValue.round()}",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)))
            ]),
            SliderTheme(
              data: SliderThemeData(
                  trackHeight: 10,
                  thumbColor: Colors.white,
                  activeTickMarkColor: Color.fromARGB(255, 10, 102, 230),
                  inactiveTickMarkColor: Colors.white,
                  thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10)),
              child: Slider(
                inactiveColor: Color.fromARGB(255, 255, 255, 255),
                value: _currentSliderValue,
                max: 100,
                label: _currentSliderValue.round().toString(),
                onChanged: (double value) {
                  setState(() {
                    _currentSliderValue = value;
                  });
                },
              ),
            ),
          ],
        )
      ],
    );
  }
}

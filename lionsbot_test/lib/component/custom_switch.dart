import 'package:flutter/material.dart';

class CutomSwitch extends StatelessWidget {
  const CutomSwitch(
      {Key? key,
      required this.label,
      required this.value,
      required this.onChanged,
      required this.icon})
      : super(key: key);

  final String label;
  final bool value;
  final Function onChanged;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      // ignore: sort_child_properties_last
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      margin: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
      child: Row(children: [
        Icon(
          icon,
          color: Colors.white,
          size: 25,
        ),
        Text(
          label,
          style: const TextStyle(color: Colors.white),
        ),
        Switch(
          value: value,
          onChanged: (b) {
            onChanged(b);
          },
          activeTrackColor: Colors.lightBlue,
          activeColor: Colors.blue,
        )
      ]),
    );
  }
}

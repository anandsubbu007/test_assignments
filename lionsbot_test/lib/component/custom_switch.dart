// ignore_for_file: library_private_types_in_public_api

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
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      margin: const EdgeInsets.only(left: 5, right: 5, top: 10, bottom: 10),
      child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Icon(icon, color: Colors.white, size: 25),
        Text(label, style: const TextStyle(color: Colors.white)),
        const SizedBox(width: 15),
        CustomToggleSwitch(
            value: value,
            onChanged: (b) {
              onChanged(b);
            })
        // Container(
        //   decoration: BoxDecoration(
        //       border: Border.all(color: Colors.white),
        //       borderRadius: BorderRadius.circular(100)),
        //   child: CupertinoSwitch(
        //     value: value,
        //     onChanged: (b) {
        //       onChanged(b);
        //     },
        //     trackColor: value ? Colors.lightBlue : Colors.white10,
        //     activeColor: Colors.blue,
        //   ),
        // )
      ]),
    );
  }
}

class CustomToggleSwitch extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const CustomToggleSwitch(
      {Key? key, required this.value, required this.onChanged})
      : super(key: key);

  @override
  _CustomToggleSwitchState createState() => _CustomToggleSwitchState();
}

class _CustomToggleSwitchState extends State<CustomToggleSwitch>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController!,
      builder: (context, child) {
        return GestureDetector(
          onTap: () {
            if (_animationController!.isCompleted) {
              _animationController!.reverse();
            } else {
              _animationController!.forward();
            }
            widget.value == false
                ? widget.onChanged(true)
                : widget.onChanged(false);
          },
          child: Container(
            width: 60.0,
            height: 30.0,
            decoration: BoxDecoration(
              color: widget.value ? Colors.blue : Colors.white10,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: Colors.white, width: 1),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(1, 1, 1, 1),
              child: Container(
                alignment:
                    widget.value ? Alignment.centerRight : Alignment.centerLeft,
                child: Container(
                  width: 25.0,
                  height: 25.0,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.white),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

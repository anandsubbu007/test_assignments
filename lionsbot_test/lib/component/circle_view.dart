import 'package:flutter/material.dart';

class CircleView extends StatelessWidget {
  final double size;
  final Color color;
  final List<BoxShadow> boxShadow;
  final Border border;

  const CircleView({super.key, 
    required this.size,
    this.color = Colors.transparent,
    required this.boxShadow,
    required this.border,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: border,
        boxShadow: boxShadow,
      ),
      child: const Padding(
        padding: EdgeInsets.all(1),
      ),
    );
  }

  factory CircleView.joystickCircle(double size) => CircleView(
        size: size,
        color: const Color.fromARGB(255, 64, 69, 192),
        border: Border.all(
          color: Colors.white,
          width: 4.0,
          style: BorderStyle.solid,
        ),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Colors.black12,
            spreadRadius: 8.0,
            blurRadius: 8.0,
          )
        ],
      );

  factory CircleView.joystickInnerCircle(double size) => CircleView(
        size: size,
        color: const Color.fromARGB(255, 66, 156, 221),
        border: Border.all(
          color: Colors.black26,
          width: 2.0,
          style: BorderStyle.solid,
        ),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Colors.black12,
            spreadRadius: 8.0,
            blurRadius: 8.0,
          )
        ],
      );
  factory CircleView.joystickInnerchildCircle(double size) => CircleView(
        size: size,
        color: const Color.fromARGB(255, 64, 69, 192),
        border: Border.all(
          color: const Color.fromARGB(255, 64, 69, 192),
          width: 2.0,
          style: BorderStyle.solid,
        ),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Colors.transparent,
            spreadRadius: 8.0,
            blurRadius: 8.0,
          )
        ],
      );
}

import 'package:flutter/material.dart';
import 'package:lionsbot_test/component/joystick/joy_stick.dart';

class JoyStickHandle extends StatelessWidget {
  const JoyStickHandle({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Align(
            alignment: Alignment.center,
            child: Icon(Icons.arrow_drop_up, color: Colors.white, size: 50),
          ),
          Row(
            children: [
              const Icon(Icons.arrow_left, color: Colors.white, size: 50),
              Expanded(
                child: LayoutBuilder(builder: (context, cc) {
                  final radius = (cc.minWidth / 2).ceilToDouble();
                  return JoyStick(
                    radius: radius,
                    stickRadius: radius / 2,
                    callback: (_, __) {},
                  );
                }),
              ),
              const Icon(Icons.arrow_right, color: Colors.white, size: 50),
            ],
          ),
          const Align(
            alignment: Alignment.center,
            child: Icon(Icons.arrow_drop_down, color: Colors.white, size: 50),
          ),
        ],
      ),
    );
  }
}

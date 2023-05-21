import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'circle_view.dart';

class JoystickView extends StatelessWidget {
  final double size;
  final Color iconsColor;
  final double opacity;
  final bool showArrows;

  const JoystickView(
      {super.key,
      required this.size,
      this.iconsColor = Colors.white,
      required this.opacity,
      this.showArrows = true});

  @override
  Widget build(BuildContext context) {
    double actualSize = size;
    double innerCircleSize = actualSize / 2;
    Offset lastPosition = Offset(innerCircleSize, innerCircleSize);
    Offset joystickInnerPosition = _calculatePositionOfInnerCircle(
        lastPosition, innerCircleSize, actualSize, const Offset(0, 0));
    return Center(
      child: StatefulBuilder(
        builder: (context, setState) {
          Widget joystick = Stack(
            children: <Widget>[
              Container(
                  padding: const EdgeInsets.all(25),
                  child: CircleView.joystickCircle(
                    actualSize,
                  )),
              Positioned(
                top: joystickInnerPosition.dy + 25,
                left: joystickInnerPosition.dx + 25,
                child: Draggable<CircleView>(
                  feedback: CircleView.joystickInnerCircle(
                    actualSize / 2,
                  ),
                  childWhenDragging: CircleView.joystickInnerchildCircle(
                    actualSize / 2,
                  ),
                  child: CircleView.joystickInnerCircle(
                    actualSize / 2,
                  ),
                ),
              ),
              if (showArrows) ...createArrows(),
            ],
          );

          return GestureDetector(
            onPanStart: (details) {},
            onPanEnd: (details) {
              joystickInnerPosition = _calculatePositionOfInnerCircle(
                  Offset(innerCircleSize, innerCircleSize),
                  innerCircleSize,
                  actualSize,
                  const Offset(0, 0));
            },
            onPanUpdate: (details) {
              joystickInnerPosition = _calculatePositionOfInnerCircle(
                  lastPosition,
                  innerCircleSize,
                  actualSize,
                  details.localPosition);
            },
            child: Opacity(opacity: opacity, child: joystick),
          );
        },
      ),
    );
  }

  List<Widget> createArrows() {
    return [
      Positioned(
        top: -16.0,
        left: 0.0,
        right: 0.0,
        child: Icon(
          Icons.arrow_drop_up,
          color: iconsColor,
          size: 40,
        ),
      ),
      Positioned(
        top: 0.0,
        bottom: 0.0,
        left: -16.0,
        child: Icon(
          Icons.arrow_left,
          color: iconsColor,
          size: 40,
        ),
      ),
      Positioned(
        top: 0.0,
        bottom: 0.0,
        right: -16.0,
        child: Icon(
          Icons.arrow_right,
          color: iconsColor,
          size: 40,
        ),
      ),
      Positioned(
        bottom: -16.0,
        left: 0.0,
        right: 0.0,
        child: Icon(
          Icons.arrow_drop_down,
          color: iconsColor,
          size: 40,
        ),
      ),
    ];
  }

  Offset _calculatePositionOfInnerCircle(
      Offset lastPosition, double innerCircleSize, double size, Offset offset) {
    double middle = size + 25 / 2.0;

    double angle = math.atan2(offset.dy - middle, offset.dx - middle);
    double degrees = angle * 180 / math.pi;
    if (offset.dx < middle && offset.dy < middle) {
      degrees = 360 + degrees;
    }
    bool isStartPosition = lastPosition.dx == innerCircleSize &&
        lastPosition.dy == innerCircleSize;
    double lastAngleRadians =
        (isStartPosition) ? 0 : (degrees) * (math.pi / 180.0);

    var rBig = size / 2;
    var rSmall = innerCircleSize / 2;

    var x = (lastAngleRadians == -1)
        ? rBig - rSmall
        : (rBig - rSmall) + (rBig - rSmall) * math.cos(lastAngleRadians);
    var y = (lastAngleRadians == -1)
        ? rBig - rSmall
        : (rBig - rSmall) + (rBig - rSmall) * math.sin(lastAngleRadians);

    var xPosition = lastPosition.dx - rSmall;
    var yPosition = lastPosition.dy - rSmall;

    var angleRadianPlus = lastAngleRadians + math.pi / 2;
    if (angleRadianPlus < math.pi / 2) {
      if (xPosition > x) {
        xPosition = x;
      }
      if (yPosition < y) {
        yPosition = y;
      }
    } else if (angleRadianPlus < math.pi) {
      if (xPosition > x) {
        xPosition = x;
      }
      if (yPosition > y) {
        yPosition = y;
      }
    } else if (angleRadianPlus < 3 * math.pi / 2) {
      if (xPosition < x) {
        xPosition = x;
      }
      if (yPosition > y) {
        yPosition = y;
      }
    } else {
      if (xPosition < x) {
        xPosition = x;
      }
      if (yPosition < y) {
        yPosition = y;
      }
    }
    return Offset(xPosition, yPosition);
  }
}

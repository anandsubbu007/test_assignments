// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'dart:math' as math;

class JoyStick extends StatefulWidget {
  final double radius;
  final double stickRadius;
  final Function(int vDirection, int vSpeed) callback;

  const JoyStick(
      {Key? key,
      required this.radius,
      required this.stickRadius,
      required this.callback})
      : super(key: key);

  @override
  _JoyStickState createState() => _JoyStickState();
}

class _JoyStickState extends State<JoyStick> {
  final GlobalKey _joyStickContainer = GlobalKey();
  double yOff = 0, xOff = 0;
  double _x = 0, _y = 0;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final RenderBox renderBoxWidget =
          _joyStickContainer.currentContext?.findRenderObject() as RenderBox;
      final offset = renderBoxWidget.localToGlobal(Offset.zero);
      xOff = offset.dx;
      yOff = offset.dy;
    });

    _centerStick();
  }

  void _centerStick() {
    setState(() {
      _x = widget.radius;
      _y = widget.radius;
    });

    _sendCoordinates(_x, _y);
  }

  int map(num x, num inMin, num inMax, num outMin, num outMax) {
    return ((x - inMin) * (outMax - outMin) / (inMax - inMin) + outMin).floor();
  }

  void _onPointerMove(PointerEvent details) {
    final x = details.position.dx - xOff;
    final y = details.position.dy - yOff;
    if (isStickInside(x, y, widget.radius, widget.radius,
        widget.radius - widget.stickRadius)) {
      // x and y cordinates

      setState(() {
        _x = x;
        _y = y;
      });

      _sendCoordinates(x, y);
    }
  }

  void _onPointerUp(PointerUpEvent event) {
    _centerStick();
  }

  void _sendCoordinates(double x, double y) {
    double speed = y - widget.radius;
    double direction = x - widget.radius;

    var vSpeed = -1 *
        map(speed, 0, (widget.radius - widget.stickRadius).floor(), 0, 100);
    var vDirection =
        map(direction, 0, (widget.radius - widget.stickRadius).floor(), 0, 100);

    widget.callback(vDirection, vSpeed);
  }

  bool isStickInside(x, y, circleX, circleY, circleRadius) {
    var absX = math.pow((x - circleX).abs(), 2.0);
    var absY = math.pow((y - circleY).abs(), 2.0);
    return math.sqrt(absX + absY) < circleRadius;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Listener(
        behavior: HitTestBehavior.opaque,
        onPointerMove: _onPointerMove,
        onPointerUp: _onPointerUp,
        child: Container(
          key: _joyStickContainer,
          width: widget.radius * 2,
          height: widget.radius * 2,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.radius),
            color: const Color.fromARGB(255, 64, 109, 192),
            border: Border.all(
                color: Colors.white, width: 4.0, style: BorderStyle.solid),
            boxShadow: const <BoxShadow>[
              BoxShadow(color: Colors.black12, spreadRadius: 8, blurRadius: 8)
            ],
          ),
          child: Stack(
            children: [
              Positioned(
                left: _x - widget.stickRadius,
                top: _y - widget.stickRadius,
                child: Container(
                  width: widget.stickRadius * 2,
                  height: widget.stickRadius * 2,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 66, 156, 221),
                    border: Border.all(
                        color: const Color.fromARGB(255, 109, 174, 221),
                        width: 3,
                        style: BorderStyle.solid),
                    boxShadow: const <BoxShadow>[
                      BoxShadow(
                          color: Colors.black54,
                          spreadRadius: 5,
                          offset: Offset(1, 2),
                          blurRadius: 6)
                    ],
                    borderRadius: BorderRadius.circular(widget.stickRadius),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

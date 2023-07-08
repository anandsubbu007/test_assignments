import 'package:flutter/material.dart';

class FilledAppButton extends StatelessWidget {
  const FilledAppButton(
      {super.key,
      required this.label,
      this.margin =
          const EdgeInsets.only(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0),
      this.outlineButton = false,
      this.onPressed,
      this.icon = const Icon(Icons.ac_unit, color: Colors.transparent),
      this.paddingRightValue = 0.0,
      this.buttonColor});
  final Widget icon;
  final String label;

  final Color borderColor = Colors.transparent;
  final double height = 50;
  final EdgeInsets margin;

  final double paddingRightValue;

  final double width = double.infinity;
  final double radius = 7.5;

  final Color textColor = Colors.white;
  final Color? buttonColor;
  final double fontSize = 16.0;

  final bool enabled = true;
  final bool outlineButton;
  final bool visible = true;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: width,
        child: Container(
          decoration: BoxDecoration(
              color: outlineButton ? null : Theme.of(context).primaryColor,
              border: Border.all(
                  color: buttonColor ?? Theme.of(context).primaryColor),
              borderRadius: BorderRadius.circular(radius)),
          height: height,
          margin: margin,
          child: outlineButton
              ? OutlinedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(radius))),
                  ),
                  onPressed: onPressed,
                  child: Text(label,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: fontSize,
                          color: Theme.of(context).primaryColor)),
                )
              : Stack(alignment: Alignment.centerRight, children: [
                  GestureDetector(
                      onTap: onPressed,
                      child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.only(
                              top: 11, bottom: 11, right: paddingRightValue),
                          decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(radius)),
                          child: Text(label,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: fontSize, color: Colors.white)))),
                ]),
        ));
  }
}

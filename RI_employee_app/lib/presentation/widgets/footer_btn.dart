import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  const ActionButton(
      {super.key,
      required this.title,
      this.color,
      this.fontColor,
      this.isDense = false,
      required this.onPressed});
  final String title;
  final Color? color;
  final Color? fontColor;
  final bool isDense;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
          backgroundColor: color ?? Colors.blue,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: isDense ? 2 : 5, vertical: isDense ? 1 : 2),
        child: Text(
          title,
          style: TextStyle(
            color: fontColor ?? Colors.white,
            fontSize: isDense ? 12 : 14,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class DateBtn extends StatelessWidget {
  const DateBtn(
      {super.key,
      required this.isSelected,
      required this.title,
      required this.onPressed});
  final bool isSelected;
  final String title;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 8),
      constraints: const BoxConstraints(maxWidth: 160),
      // margin: EdgeInsets.symmetric(horizontal: 10),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
            backgroundColor:
                isSelected ? Colors.blue : Colors.blue.withOpacity(.1),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.blue,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}

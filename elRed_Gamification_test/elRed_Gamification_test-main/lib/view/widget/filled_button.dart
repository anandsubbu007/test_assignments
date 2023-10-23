import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_app/utils/constant/color_utils.dart';

class FilledAppButton extends StatelessWidget {
  final bool isDisabled;
  final String? title;
  final Widget? child;
  final Function() onTap;

  const FilledAppButton(
      {super.key,
      this.isDisabled = false,
      this.title,
      this.child,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(3),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
            color: isDisabled ? AppColor.disabled : AppColor.focused,
            borderRadius: BorderRadius.circular(6)),
        alignment: Alignment.center,
        child: child ??
            Text(
              title ?? "",
              style: context.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600, color: AppColor.baground),
            ),
      ),
    );
  }
}

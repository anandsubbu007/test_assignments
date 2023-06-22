import 'package:employee_app/utils/constant/app_colors.dart';
import 'package:flutter/material.dart';

class RoleSelectionSheet extends StatelessWidget {
  RoleSelectionSheet({super.key, required this.onSelected});
  final Function(String value) onSelected;

  final List<String> options = [
    "Product Designer",
    "Flutter Developer",
    "QA Tester",
    "Product Owner",
  ];
  void callSheet(BuildContext context) {
    const radius = BorderRadius.only(
        topLeft: Radius.circular(16), topRight: Radius.circular(16));
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: radius),
      builder: (ctx) => ClipRRect(borderRadius: radius, child: this),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: List.generate(options.length, (index) {
        return InkWell(
          onTap: () {
            Navigator.pop(context);
            onSelected.call(options[index]);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 15),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                    bottom: BorderSide(
                  color: AppColors.borderGrey.withOpacity(.3),
                ))),
            child: Center(
              child: Text(options[index]),
            ),
          ),
        );
      }),
    );
  }
}

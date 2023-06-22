import 'package:employee_app/utils/constant/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class NoDataWidget extends StatelessWidget {
  const NoDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 200),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              AppIcons.icNoData,
              height: 200,
            ),
            const SizedBox(height: 5),
            const Text(
              "No employee records found",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
      ),
    );
  }
}

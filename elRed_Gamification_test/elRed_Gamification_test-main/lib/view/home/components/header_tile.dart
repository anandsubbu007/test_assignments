import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_app/utils/constant/color_utils.dart';
import 'package:flutter_app/view_model/provider/home_page_control.dart';

class HeadingTile extends StatelessWidget {
  const HeadingTile({super.key});

  @override
  Widget build(BuildContext context) {
    final heading = context.select((HomePageControl value) => value.heading);
    final stepCountPercent =
        context.select((HomePageControl value) => value.stepCountPercent);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: FittedBox(
                alignment: Alignment.centerLeft,
                fit: BoxFit.scaleDown,
                child: Text(
                  heading,
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: context.textTheme.titleLarge!
                      .copyWith(color: AppColor.foreGround),
                ),
              ),
            ),
          ),
          const SizedBox(height: 6),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
            height: 12,
            width: double.infinity,
            child: LayoutBuilder(builder: (ctx, con) {
              final fillRatio = con.maxWidth * stepCountPercent;
              return ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  color: Colors.white,
                  height: 15,
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                          color: AppColor.focused,
                          child: SizedBox(height: 15, width: fillRatio)),
                      const Spacer()
                    ],
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 6),
        ],
      ),
    );
  }
}

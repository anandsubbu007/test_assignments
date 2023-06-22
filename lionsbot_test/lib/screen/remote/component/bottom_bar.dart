import 'package:flutter/material.dart';
import 'package:lionsbot_test/component/custom_scroll_view.dart';

class SettingBottomOption extends StatelessWidget {
  const SettingBottomOption({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.10,
      minChildSize: 0.10,
      maxChildSize: .24,
      builder: (BuildContext context, ScrollController scrollController) {
        return CustomScrollViewContent(
          scrollController: scrollController,
        );
      },
    );
  }
}

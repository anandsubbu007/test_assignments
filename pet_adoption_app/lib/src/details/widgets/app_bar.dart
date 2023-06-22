import 'package:flutter/material.dart';
import 'package:pet_adoption_app/provider/adoption.dart';
import 'package:pet_adoption_app/utils/theme/theme.dart';

/// App BAr for this app
class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// title
  final String title;
  final bool showClearButton;
  const MyAppBar(
      {super.key, this.showClearButton = false, required this.title});

  @override
  Size get preferredSize => const Size(double.infinity, 70);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).cardColor,
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton.filledTonal(
              key: const Key("pop_history"),
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back_sharp)),
          Expanded(
              child: Text(
            "Pet Adoption",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge,
          )),
          IconButton.filledTonal(
              onPressed: showClearButton
                  ? () async {
                      await Provider.of<AdoptionProvider>(context,
                              listen: false)
                          .removeAll();
                      if (context.mounted) Navigator.pop(context);
                    }
                  : null,
              icon: !showClearButton
                  ? const SizedBox()
                  : const Icon(Icons.clear_all)),
        ],
      ),
    );
  }
}

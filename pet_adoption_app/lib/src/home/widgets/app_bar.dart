import 'package:flutter/material.dart';
import 'package:pet_adoption_app/src/home/bloc/home_bloc.dart';
import 'package:pet_adoption_app/utils/theme/theme.dart';

/// Home page App Bar
class HomeAppBar extends StatefulWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Size get preferredSize => const Size(double.infinity, 70);
  @override
  State<HomeAppBar> createState() => _HomeAppBarState();
}

class _HomeAppBarState extends State<HomeAppBar> {
  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeManager>();
    return ClipRRect(
      borderRadius: const BorderRadius.only(
          bottomRight: Radius.circular(20), bottomLeft: Radius.circular(20)),
      child: Container(
        color: Theme.of(context).cardColor,
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton.filled(
                key: const Key("theme"),
                onPressed: () {
                  context.read<ThemeManager>().setTheme(
                      theme.isDarkMode ? ThemeMode.light : ThemeMode.dark);
                },
                icon: Icon(
                    theme.isDarkMode ? Icons.light_mode : Icons.dark_mode)),
            Expanded(
                child: Text(
              "Pet Adoption",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge,
            )),
            IconButton.filled(
                key: const Key("historyKey"),
                onPressed: () {
                  context.read<HomeBloc>().onTapHistory(context);
                },
                icon: const Icon(Icons.history)),
          ],
        ),
      ),
    );
  }
}

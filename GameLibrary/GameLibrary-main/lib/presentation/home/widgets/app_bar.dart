import 'package:flutter/material.dart';
import 'package:flutter_ap/infrastructure/api_service/api_service.dart';
import 'package:flutter_ap/presentation/home/bloc/home_bloc.dart';
import 'package:flutter_ap/utils/theme/theme.dart';

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
              "Games",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge,
            )),
            IconButton.filled(
                onPressed: () {
                  FocusNode().requestFocus();
                  const FilterSheet().callSheet(context);
                },
                icon: const Icon(Icons.filter_alt_rounded)),
          ],
        ),
      ),
    );
  }
}

class FilterSheet extends StatefulWidget {
  const FilterSheet({super.key});

  Future callSheet(BuildContext context) async {
    showBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (ctx) => this);
  }

  @override
  State<FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends State<FilterSheet> {
  List<int> selectedGeners = [], selectedPlatform = [];
  @override
  Widget build(BuildContext context) {
    selectedGeners = [...context.read<HomeBloc>().lstGenFiltered];
    selectedPlatform = [...context.read<HomeBloc>().lastPlatformFiltered];
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        child: Scaffold(
          body: Material(
            child: SingleChildScrollView(
              child: Column(children: [
                PlatformListing(selected: selectedPlatform),
                GeneresListing(selected: selectedGeners),
              ]),
            ),
          ),
          floatingActionButton: Row(
            children: [
              const SizedBox(width: 32),
              FloatingActionButton.extended(
                  label: const Text("Clear"),
                  onPressed: () {
                    Navigator.pop(context);
                    context
                        .read<HomeBloc>()
                        .add(HomeSearchEvent(geners: [], platform: []));
                  }),
              const Spacer(),
              FloatingActionButton.extended(
                  label: const Text("Apply"),
                  onPressed: () {
                    Navigator.pop(context);
                    context.read<HomeBloc>().add(HomeSearchEvent(
                        geners: selectedGeners, platform: selectedPlatform));
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

class GeneresListing extends StatelessWidget {
  final List<int> selected;
  const GeneresListing({super.key, required this.selected});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(5),
          child: Text(
            "Geners",
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        const Divider(height: 1),
        FutureBuilder(
            future: ApiService.getAllGeners(),
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return const Padding(
                  padding: EdgeInsets.all(35.0),
                  child: CircularProgressIndicator(),
                );
              }
              final datas = snapshot.data ?? [];
              return ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: datas.length,
                itemBuilder: (context, index) {
                  return FilterTextTile(
                    title: (datas[index].name ?? ''),
                    isSelected: () => selected.contains(datas[index].id),
                    onTap: () {
                      !selected.contains(datas[index].id)
                          ? selected.add(datas[index].id!)
                          : selected.remove(datas[index].id!);
                    },
                  );
                },
                shrinkWrap: true,
              );
            })
      ],
    );
  }
}

class PlatformListing extends StatelessWidget {
  final List<int> selected;
  const PlatformListing({super.key, required this.selected});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(5),
          child: Text(
            "Platform",
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        const Divider(height: 1),
        FutureBuilder(
            future: ApiService.getAllPlatoforms(),
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return const Padding(
                  padding: EdgeInsets.all(35.0),
                  child: CircularProgressIndicator(),
                );
              }
              final datas = snapshot.data ?? [];
              return ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: datas.length,
                itemBuilder: (context, index) {
                  return FilterTextTile(
                    title: (datas[index].name ?? ''),
                    isSelected: () => selected.contains(datas[index].id),
                    onTap: () async {
                      !selected.contains(datas[index].id)
                          ? selected.add(datas[index].id!)
                          : selected.remove(datas[index].id!);
                    },
                  );
                },
                shrinkWrap: true,
              );
            })
      ],
    );
  }
}

class FilterTextTile extends StatelessWidget {
  final String title;
  final Function() onTap;
  final bool Function()? isSelected;
  const FilterTextTile(
      {super.key, required this.title, required this.onTap, this.isSelected});

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, ss) {
      void onTapButton() {
        onTap();
        ss(() {});
      }

      return ListTile(
        title: Text(title),
        onTap: onTapButton,
        trailing: Checkbox(
            value: isSelected?.call(), onChanged: (_) => onTapButton()),
      );
    });
  }
}

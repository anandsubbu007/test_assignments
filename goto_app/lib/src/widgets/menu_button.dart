import 'package:flutter/material.dart';
import 'package:goto_app/src/bloc/cubit.dart';
import 'package:goto_app/src/service/api_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../utils/context_ext.dart';

class DotMenu extends StatelessWidget {
  const DotMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      onSelected: (val) {
        context.read<RepoCubit>().fetchData(val);
      },
      padding: const EdgeInsets.only(right: 24, left: 10),
      position: PopupMenuPosition.under,
      itemBuilder: (context) {
        return SortBy.values
            .map((e) => PopupMenuItem(
                  value: e,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                  child: Text('Sort by ${e.title}',
                      style: context.textThem.bodyLarge),
                ))
            .toList();
      },
      child: const Icon(Icons.more_vert_sharp),
    );
  }
}

// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:goto_app/src/home/repo_tiles.dart';
import 'package:goto_app/src/model/data_model.dart';

class RepoBody extends StatelessWidget {
  final List<RepoDataM> datas;
  const RepoBody({required this.datas, super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(0),
      separatorBuilder: (context, index) =>
          const Divider(height: 1, endIndent: 10, indent: 10),
      shrinkWrap: true,
      itemCount: datas.length,
      itemBuilder: (context, index) => UserTile(datas[index]),
      physics: const ClampingScrollPhysics(),
    );
  }
}

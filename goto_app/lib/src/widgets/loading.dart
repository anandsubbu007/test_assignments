import 'package:flutter/material.dart';
// import 'package:goto_app/src/home/repo_tiles.dart';
import 'package:skeletons/skeletons.dart';

class LoadingBody extends StatelessWidget {
  const LoadingBody({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => const Divider(),
      itemCount: 10,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return const LoadingTile();
      },
    );
  }
}

class LoadingTile extends StatelessWidget {
  const LoadingTile({super.key});

  @override
  Widget build(BuildContext context) {
    return SkeletonListTile(
        padding: const EdgeInsets.fromLTRB(20, 10, 36, 10),
        leadingStyle: _leading,
        titleStyle: _titleLoad,
        hasSubtitle: true,
        subtitleStyle: _subTitleLoad);
  }

  static SkeletonAvatarStyle get _leading =>
      const SkeletonAvatarStyle(height: 42, width: 42, shape: BoxShape.circle);

  static SkeletonAvatar get leading => SkeletonAvatar(style: _leading);
  static SkeletonLine get titleLoad => SkeletonLine(style: _titleLoad);
  static SkeletonLine get subTitleLoad => SkeletonLine(style: _subTitleLoad);

  static SkeletonLineStyle get _titleLoad => SkeletonLineStyle(
      borderRadius: BorderRadius.circular(20), height: 10, width: 100);
  static SkeletonLineStyle get _subTitleLoad =>
      SkeletonLineStyle(borderRadius: BorderRadius.circular(20), height: 10);
}

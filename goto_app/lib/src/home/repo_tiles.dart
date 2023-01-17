// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:goto_app/generated/assets.gen.dart';
import 'package:goto_app/src/home/text_fadein.dart';
import 'package:goto_app/src/model/data_model.dart';
import '../utils/context_ext.dart';

class UserTile extends StatelessWidget {
  final RepoDataM data;
  const UserTile(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    // bool isLoading = data == null;
    final ValueNotifier<bool> isExpanded = ValueNotifier<bool>(false);
    Widget avatar() => CircleAvatar(
        maxRadius: 20,
        backgroundImage:
            data.vAvatarUrl.isEmpty ? null : NetworkImage(data.vAvatarUrl));
    Widget repoOwnerName() => TextFadeIn(
          data.vOwnerName,
          style: context.textThem.bodyMedium!.copyWith(color: Colors.black54),
        );
    Widget repoName() =>
        TextFadeIn(data.vName, style: context.textThem.labelLarge);
    return InkWell(
      onTap: () {
        isExpanded.value = !isExpanded.value;
        isExpanded.notifyListeners();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.fromLTRB(8, 10, 8, 8),
              child: avatar()),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    repoOwnerName(),
                    const SizedBox(height: 4),
                    repoName(),
                    _RepoAddDetails(canIShow: isExpanded, data: data)
                  ]),
            ),
          ),
        ]),
      ),
    );
  }
}

class _RepoAddDetails extends StatefulWidget {
  final ValueNotifier<bool> canIShow;
  final RepoDataM data;
  const _RepoAddDetails({
    required this.canIShow,
    required this.data,
  });

  @override
  State<_RepoAddDetails> createState() => __RepoAddDetailsState();
}

class __RepoAddDetailsState extends State<_RepoAddDetails> {
  Widget detailW(AssetGenImage image, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          image.image(height: 16),
          TextFadeIn(value, style: context.textThem.bodySmall),
        ],
      ),
    );
  }

  Widget language(String value) {
    final color = ['TypeScript'].contains(value) ? Colors.blue : Colors.orange;
    return value.isEmpty
        ? const SizedBox()
        : Padding(
            padding: const EdgeInsets.fromLTRB(0, 3, 5, 3),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 10,
                  width: 10,
                  margin: const EdgeInsets.only(right: 5),
                  decoration:
                      BoxDecoration(shape: BoxShape.circle, color: color),
                ),
                TextFadeIn(value, style: context.textThem.bodySmall),
              ],
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    widget.canIShow.addListener(() {
      setState(() {});
    });

    if (!widget.canIShow.value) {
      return const SizedBox();
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.data.vDetails.isNotEmpty) const SizedBox(height: 5),
          if (widget.data.vDetails.isNotEmpty)
            Text(widget.data.vDetails,
                style: context.textThem.bodySmall
                    ?.copyWith(color: Colors.black87)),
          const SizedBox(height: 5),
          IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                language(widget.data.vLanguage),
                detailW(
                    Assets.icon.starYellow16, widget.data.vStars.toString()),
                detailW(Assets.icon.forkBlack16, widget.data.vFork.toString()),
              ],
            ),
          ),
        ],
      );
    }
  }
}

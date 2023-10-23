import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_app/utils/constant/color_utils.dart';
import 'package:flutter_app/view/home/components/header_tile.dart';
import 'package:flutter_app/view/home/components/questions_form.dart';
import 'package:flutter_app/view/widget/filled_button.dart';
import 'package:flutter_app/view_model/provider/home_page_control.dart';

class HomePg extends StatefulWidget {
  const HomePg({super.key});

  @override
  State<HomePg> createState() => _HomePgState();
}

class _HomePgState extends State<HomePg> {
  @override
  void didChangeDependencies() {
    _model = context.read<HomePageControl>();
    fetchData = _model.loadData();
    super.didChangeDependencies();
  }

  late Future fetchData;

  late HomePageControl _model;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.baground,
        title: Text(
          "Gamification",
          style: context.textTheme.headlineSmall!
              .copyWith(color: AppColor.foreGround),
        ),
        centerTitle: true,
        leading: ValueListenableBuilder(
            valueListenable: _model.isbackAvailable,
            builder: (context, v, vv) {
              return !v
                  ? const SizedBox()
                  : IconButton(
                      onPressed: () {
                        context.read<HomePageControl>().onBack(context);
                      },
                      color: AppColor.foreGround,
                      icon: const Icon(Icons.arrow_back));
            }),
      ),
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColor.baground,
      body: FutureBuilder(
          future: fetchData,
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const Center(child: CircularProgressIndicator());
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: context.htP(12),
                  child: const HeadingTile(),
                ),
                const Expanded(
                  flex: 5,
                  child: ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30)),
                      child: QuestionsForm()),
                ),
                ActionButton(onTap: () {
                  context.read<HomePageControl>().onTapNext(context);
                }),
              ],
            );
          }),
    );
  }
}

class ActionButton extends StatelessWidget {
  final bool isConfirmation;
  final Function() onTap;
  const ActionButton(
      {super.key, this.isConfirmation = false, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final isAtEnd = isConfirmation;
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(12),
      child: ValueListenableBuilder(
          valueListenable: context.read<HomePageControl>().isActionAvailable,
          builder: (context, bb, __) {
            return Row(
              children: [
                if (isAtEnd)
                  FilledAppButton(
                      child: const Icon(Icons.refresh),
                      onTap: () {
                        Navigator.pop(context);
                        context.read<HomePageControl>().loadData();
                      }),
                const SizedBox(width: 6),
                Expanded(
                  child: FilledAppButton(
                      title: isAtEnd ? "Confirm" : "Next",
                      isDisabled: !bb,
                      onTap: onTap),
                ),
              ],
            );
          }),
    );
  }
}

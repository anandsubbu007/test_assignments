// ignore_for_file: depend_on_referenced_packages

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_app/model/models/screen_model.dart';
import 'package:flutter_app/utils/constant/color_utils.dart';
import 'package:flutter_app/view/confirmation/confirmation_pg.dart';
import 'package:flutter_app/view_model/service/screen_repo.dart';

export 'package:provider/provider.dart';

class HomePageControl with ChangeNotifier {
  Repo repo;
  HomePageControl(this.repo);

  /// Current Heading
  String get heading => currentScteen?.getHeading ?? '';

  /// current Screen Question
  String get question => currentScteen?.getQuestion ?? '';

  /// completed step Percent
  double get stepCountPercent => currentIdx / (totalScreenCount - 1);

  /// Total Available screen
  int get totalScreenCount => screens.length;

  /// Message
  List<InlineSpan> messages = [];

  /// Options
  List<Options> get options => currentScteen?.options ?? [];

  /// Fields
  List<Fields> get fields => currentScteen?.fields ?? [];

  /// TextField Hint
  String? get hintText => currentScteen?.hint_text;

  /// Current screen
  Screen? get currentScteen => screens.elementAtOrNull(currentIdx);
  int currentIdx = 0;

  /// available screens
  List<Screen> screens = [];

  final formkey = GlobalKey<FormState>();

  ///
  String? fieldValue(Fields field) => currentScteen?.ans;

  ///
  void onChangeText(String value) {
    currentScteen?.ans = value;
    isActionAvailable.value = (currentScteen?.ans ?? '').isNotEmpty;
  }

  void onTapNext(BuildContext context) {
    final isvalid = formkey.currentState?.validate() ?? false;

    /// Validating current form page
    if (!isvalid) {
      return;
    }
    if (currentScteen?.ans == null) return;
    if (currentScteen!.child_screen.isNotEmpty) {
      // Updating Child Screens
      final option = currentScteen!.options
          .firstWhere((e) => e.text == currentScteen?.ans);
      final idx = screens
          .indexWhere((e) => e.parentScreen == currentScteen!.screen_name);
      // Removing PlaceHolder Child Screens
      screens.removeWhere((e) => e.parentScreen == currentScteen!.screen_name);
      // adding selected Child Screens
      if (currentScteen!.child_screen[option.key] != null) {
        screens.insertAll(idx, currentScteen!.child_screen[option.key]!);
      }
    }

    if (isAtEnd) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const ConfirmationPg(),
      ));
    } else {
      currentIdx += 1;
    }
    update(context);
  }

  /// Text spans based on heading
  Map<String, List<InlineSpan>> allMessages = {};

  void update(BuildContext? context, [bool listen = true]) {
    messages = [];
    allMessages = {};
    if (context != null) {
      try {
        for (var e in (isAtEnd ? screens : screens.sublist(0, currentIdx))) {
          if (e.ans != null) {
            if (e.child_screen.isNotEmpty) {
              messages = [];
            }
            final msg = e.getMessages(context);
            messages.addAll(msg);
            allMessages[e.heading] = messages;
          }
        }
      } catch (e) {
        //
      }
    }
    isActionAvailable.value = (currentScteen?.ans ?? '').isNotEmpty;
    isbackAvailable.value = currentIdx > 0;
    notifyListeners();
  }

  void onBack(BuildContext context) {
    if (currentIdx == 0) return;
    currentIdx -= 1;
    update(context);
  }

  /// Notifier for back button
  ValueNotifier<bool> isbackAvailable = ValueNotifier(false);

  /// Action Button Controller
  ValueNotifier<bool> isActionAvailable = ValueNotifier(false);

  /// is screen reaches end?
  bool get isAtEnd => currentIdx == (screens.length - 1);

  Future reset() async {}

  /// Initiating data from repo
  Future loadData() async {
    final allScreens = await repo.getData();
    screens = [];
    for (var e in allScreens) {
      screens.add(e);
      if (e.child_screen.values.isNotEmpty) {
        /// Initially we will select 1st child screens
        screens.addAll(e.child_screen.values.first);
      }
      // for (var c in e.child_screen.values) {
      //   screens.addAll(c.first);
      // }
    }

    currentIdx = 0;
    update(null, false);
    return screens;
  }

  /// submitting data
  Future save(BuildContext context) async {
    final re = await repo.submitData(screens);
    return re;
  }

  /// ---------------------- For Confiremation Screen
  String get name =>
      screens
          .firstWhereOrNull((e) => e.screen_name.toLowerCase().contains("name"))
          ?.ans ??
      '';
  List<InlineSpan> get personalDetails {
    final key = allMessages.keys
        .firstWhereOrNull((e) => e.toLowerCase().contains("personal details"));
    if (key == null) return [];
    return allMessages[key] ?? [];
  }

  List<InlineSpan> get keepsBusy {
    final key = allMessages.keys
        .firstWhereOrNull((e) => e.toLowerCase().contains("keep busy"));
    if (key == null) return [];
    return allMessages[key] ?? [];
  }
}

extension ScreenExt on Screen {
  List<InlineSpan> getMessages(BuildContext context) {
    if (ans == null) return [];

    return [
      TextSpan(
          text: " $question ",
          style:
              context.textTheme.titleMedium?.copyWith(color: AppColor.baground),
          children: [
            TextSpan(
                text: ans!,
                style: context.textTheme.titleMedium!.copyWith(
                    color: AppColor.baground,
                    decoration: TextDecoration.underline))
          ])
    ];
  }
}

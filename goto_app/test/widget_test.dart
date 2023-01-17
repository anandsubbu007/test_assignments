// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:goto_app/src/bloc/state.dart';
import 'package:goto_app/src/model/data_model.dart';
import 'package:goto_app/src/bloc/cubit.dart';
import 'package:goto_app/src/service/local_storage.dart';
//   String get vName => name ?? '';
// String get vOwnerName => owner?.login ?? '';
// String get vAvatarUrl => owner?.avatarUrl ?? '';
// String get vDetails => description ?? '';
// String get vLanguage => language ?? '';
// int get vStars => stargazersCount ?? 0;
// int get vFork => forksCount ?? 0;

void main() {
  late RepoCubit taskCubit;
  setUp(() async {
    taskCubit = RepoCubit();
    await LocalDb.instance.init();
  });
  group('RepoCubit test', () {
    blocTest<RepoCubit, RepoState>(
      'emits [UserProfile On Tap: SelectionChange] with correct urgent tasks',
      build: () => taskCubit,
      act: (cubit) => cubit.fetchData(),
      expect: () => [
        RepoLoading(),
        // expectLater(RepoOnData([]), RepoOnData([]))
      ],
    );

    tearDown(() => taskCubit.close());
  });
}

class SampleData {
  static RepoDataM get initialItem => RepoDataM(
      name: 'Anand',
      language: 'Dart',
      stargazersCount: 107,
      forksCount: 7,
      owner: Owner(
          login: 'Subbu',
          avatarUrl: 'https://avatars.githubusercontent.com/u/3430433?v=4'));

  static List<RepoDataM> get dataLst => [initialItem];
}

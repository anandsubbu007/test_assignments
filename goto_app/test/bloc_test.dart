// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

// ignore_for_file: depend_on_referenced_packages

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:goto_app/src/bloc/state.dart';
import 'package:goto_app/src/model/data_model.dart';
import 'package:goto_app/src/bloc/cubit.dart';
import 'package:goto_app/src/service/api_service.dart';
import 'package:goto_app/src/service/local_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mocktail/mocktail.dart';

import 'storage_test.dart';

//
class MockGitApiService extends Mock implements GitApiService {}

class MockLocalDb extends Mock implements LocalDb {}

void main() {
  MockGitApiService service = MockGitApiService();
  SharedPreferences secureStorage = MockSecureStorage();
  late final RepoCubit taskCubit;
  LocalDb localDb = MockLocalDb();
  setUp(() async {
    localDb.initSync(secureStorage);
    taskCubit = RepoCubit(service, localDb);
  });

  group('RepoCubit test', () {
    when(() => service.retriveApiData(SortBy.name))
        .thenAnswer((_) => Future.value(SampleData.dataLst));

    when(() => localDb.saveGithubRepo(SampleData.dataLst))
        .thenAnswer((_) => Future.value());

    blocTest<RepoCubit, RepoState>(
      'emits Loading Screen & onData State',
      build: () => taskCubit,
      act: (cubit) => cubit.fetchData(),
      expect: () => [RepoLoading(), RepoOnData(SampleData.dataLst)],
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

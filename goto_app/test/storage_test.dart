// ignore_for_file: depend_on_referenced_packages

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:goto_app/src/service/local_storage.dart';

import 'widget_test.dart';

class MockSecureStorage extends Mock implements SharedPreferences {}

void main() {
  group('Github Local Data Source', () {
    SharedPreferences secureStorage = MockSecureStorage();

    setUp(() async {
      LocalDb.instance.initSync(secureStorage);
    });

    // test('saveGithubRepo', () {
    //   when(
    //     () => secureStorage.setStringList('data', [any(named: 'value')]),
    //     // ignore: null_argument_to_non_null_type
    //   ).thenAnswer((inv) {
    //     return Future.value(true);
    //   });

    //   expect(LocalDb.instance.saveGithubRepo(SampleData.dataLst), completes);
    // });

    test('get GithubRepo from local data source', () {
      final List<String> encoded =
          SampleData.dataLst.map((x) => x.toMap()).toList();

      when(() => secureStorage.getStringList('data'))
          .thenAnswer((_) => encoded);

      expect(
        LocalDb.instance.getGithubRepo(),
        completion(equals(SampleData.dataLst)),
      );
    });
    test(
        'get GithubRepo from local data source '
        'Then return Empty List value', () {
      when(
        () => secureStorage.getStringList('data'),
      ).thenAnswer((_) => null);

      expect(
        LocalDb.instance.getGithubRepo(),
        completion(equals([])),
      );
    });
  });
}

// ignore_for_file: depend_on_referenced_packages

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:goto_app/src/service/local_storage.dart';

import 'bloc_test.dart';

class MockSecureStorage extends Mock implements SharedPreferences {}

void main() {
  group('Github Local Data Source', () {
    SharedPreferences secureStorage = MockSecureStorage();

    setUp(() async {
      LocalDb.instance.initSync(secureStorage);
    });
    group('RepoModel', () {
      test('value comparison', () {
        expect(SampleData.initialItem, SampleData.initialItem);
      });
      test('props value comparison', () {
        expect(SampleData.initialItem.props, SampleData.initialItem.props);
      });
    });
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

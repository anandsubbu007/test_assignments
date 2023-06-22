import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pet_adoption_app/db/storage_manager.dart';
import 'package:pet_adoption_app/provider/adoption.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bloc_test.dart';

class MockSecureStorage extends Mock implements SharedPreferences {}

void main() {
  group('Testing Data Caching', () {
    SharedPreferences secureStorage = MockSecureStorage();
    late AdoptionProvider adoption;
    setUp(() async {
      await AppStorageManager.instance.init(secureStorage);
    });
    test('Model Matching', () async {
      expect(petA, equals(petA));
    });
    test('Caching ThemeMode', () async {
      when(() => secureStorage.getString('themeMode'))
          .thenAnswer((_) => ThemeMode.dark.name);
      expect(
        AppStorageManager.instance.getThemeMode(),
        (equals(ThemeMode.dark)),
      );
    });
    test('Testing Caching od Adoption id', () async {
      when(() => secureStorage.getStringList('adopted'))
          .thenAnswer((_) => ["500"]);
      adoption = AdoptionProvider();
      expect(adoption.adoptedIds, contains("500"));
    });
  });
}

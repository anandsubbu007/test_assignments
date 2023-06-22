// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nock/nock.dart';
import 'package:pet_adoption_app/db/storage_manager.dart';
import 'package:pet_adoption_app/main.dart';
import 'package:pet_adoption_app/src/details/details_pg.dart';
import 'package:pet_adoption_app/src/history/widgets/history.dart';
import 'package:pet_adoption_app/src/home/widgets/pet_widget.dart';

import 'storage_test.dart';

void main() {
  setUpAll(() {
    nock.init();
  });
  late MockSecureStorage pref;
  setUp(() async {
    pref = MockSecureStorage();
    await AppStorageManager.instance.init(pref);
  });
  group("Widget Testing For Adoption State", () {
    testWidgets("Adoption State Management", (tester) async {
      await tester.pumpWidget(TickerMode(
        child: PetApp(),
        enabled: false,
      ));
      await tester.pumpAndSettle(const Duration(seconds: 2));

      final listing = find.byKey(const Key("PetListView"));
      expect(listing, findsOneWidget);

      /// Checking for Search Box
      var textField = find.byKey(const Key("searchField"));
      expect(textField, findsOneWidget);
      await tester.pump(const Duration(seconds: 1));

      /// Checking for pet listing
      if (tester
          .widgetList<ListView>(find.byKey(const Key("petList")))
          .isNotEmpty) {
        final firstTile = find.byKey(const Key("petList_0"));
        expect(firstTile, findsOneWidget);
        final wid = tester.widget<PetWidget>(firstTile);

        /// Tapping One of the Tile
        await tester.tap(firstTile);
        await tester.pumpAndSettle(const Duration(seconds: 2));

        /// Going to detail page
        expect(find.byType(DetailsBody), findsOneWidget);
        await tester.pumpAndSettle(const Duration(seconds: 1));

        /// Checking for Pet Name Match
        expect(find.text(wid.pet.name), findsAtLeastNWidgets(1));
        final adoptKey = find.byKey(const Key("adopt"));

        /// Checking for Adoption Key
        expect(adoptKey, findsOneWidget);
        await tester.tap(adoptKey);
        await tester.pumpAndSettle(const Duration(seconds: 3));
        when(() => pref.getStringList("adopted"))
            .thenAnswer((_) => [wid.pet.id]);

        when(() => pref.setStringList("adopted", [wid.pet.id]))
            .thenAnswer((_) async => true);

        await tester.tapAt(Offset(10, 10));
        await tester.pumpAndSettle(const Duration(seconds: 3));
        final adoptKey1 = find.byKey(const Key("adopt"));

        // Checking for Adoption Key
        expect(adoptKey1, findsOneWidget);
        //  Going back to Home Page
        final popKey = find.byKey(const Key("pop_detail"));
        await tester.tap(popKey);
        await tester.pumpAndSettle();

        /// going to history Page
        final historyKey = find.byKey(const Key("historyKey"));
        await tester.tap(historyKey);
        await tester.pumpAndSettle();

        /// Checking for History page
        final historyPgKey = find.byType(History);
        await tester.tap(historyPgKey);
        await tester.pumpAndSettle(const Duration(seconds: 3));

        final tileinHistory = find.text(wid.pet.name);
        expect(tileinHistory, findsAtLeastNWidgets(1));

        /// back To Home Page
        final popKey2 = find.byKey(const Key("pop_history"));
        await tester.tap(popKey2);
        await tester.pumpAndSettle();
      }
    });
  });
}

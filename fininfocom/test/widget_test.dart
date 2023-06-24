import 'package:fininfocom/main.dart';
import 'package:fininfocom/presentaion/profile_pg.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUp(() {});

  group("Widget Testing", ()  {
    testWidgets("", (tester) async {
      await tester.pumpWidget(const TickerMode(enabled: false, child: MyApp()));
      await tester.pumpAndSettle(const Duration(seconds: 2));

      /// checking for Refresh button
      final refreshKey = find.byKey(const Key("refresh_key_dog"));
      expect(refreshKey, findsOneWidget);

      /// checking for Image Widget
      await tester.pumpAndSettle(const Duration(seconds: 2));
      final image1 = find.byKey(const Key("image"));
      expect(image1, findsOneWidget);
      await tester.tap(refreshKey);
      await tester.pumpAndSettle(const Duration(seconds: 2));
      final image2 = find.byKey(const Key("image"));
      expect(image2, findsOneWidget);

      final toProfile = find.byKey(const Key("to_profile_pg"));
      expect(toProfile, findsOneWidget);
      await tester.tap(toProfile);
      await tester.pumpAndSettle(const Duration(seconds: 2));

      /// Checking for next page navigation
      final profilePg = find.byType(ProfilePg);
      expect(profilePg, findsOneWidget);

      /// checking for pop button
      final popProfile = find.byKey(const Key("pop"));
      expect(popProfile, findsOneWidget);
      await tester.tap(popProfile);
      await tester.pumpAndSettle(const Duration(seconds: 2));

      /// back to randomn Page
      final randomImgPg = find.byKey(const Key("RandomImgPg"));
      expect(randomImgPg, findsOneWidget);
    });
  });
}

import 'dart:math';
import 'package:deriv_test/src/widgets/price_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:deriv_test/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('User Fetching', () {
    AppTesting apptesting;
    testWidgets('App Intilization', (WidgetTester tester) async {
      app.main();
      apptesting = AppTesting(tester: tester);
      await apptesting.checkForIntalized();
    });
  });
}

class AppTesting {
  WidgetTester tester;
  AppTesting({required this.tester});

  int marketLen = 0, symbolLen = 0;
  Future checkForIntalized() async {
    await tester.pumpAndSettle();
    var byKeyStream1 = find.byKey(const Key('Stream1'));
    expect(byKeyStream1, findsOneWidget);
    await tester.pump(const Duration(seconds: 1));
    await tester.ensureVisible(find.byKey(const Key('Market')));
    await tester.pumpAndSettle();

    expect(drop1, findsOneWidget);
    expect(drop2, findsOneWidget);
    expect(marketDropdown.value, equals(null));
    expect(symbolDropdown.value, equals(null));
    expect(marketDropdown.items?.length ?? 0, greaterThan(0));
    marketLen = marketDropdown.items!.length;
    await onSelectMarket();
    await afterMarketSelected();
    await Future.delayed(const Duration(seconds: 2));
    await onSelectMarket();
    await afterMarketSelected();
  }

  int indexAt(int marketLen) {
    return Random().nextInt(marketLen - 1);
  }

  Finder get drop1 => find.byKey(const Key('Market'));
  Finder get drop2 => find.byKey(const Key('Symbol'));
  Finder get priceKey => find.byKey(const Key('Price'));
  DropdownButton get symbolDropdown => tester.widget<DropdownButton>(drop2);
  DropdownButton get marketDropdown => tester.widget<DropdownButton>(drop1);
  PriceWidget get priceWidget => tester.widget<PriceWidget>(priceKey);

  Future onSelectMarket() async {
    // Opening Dropdown
    await tester.tap(drop1);
    await tester.pumpAndSettle();
    // print(find.byKey(marketDropdown.items!.first.key!));
    final item1 = find
        .byKey(marketDropdown.items!.elementAt(indexAt(marketLen)).key!)
        .last;
    await tester.ensureVisible(item1);
    await tester.pump();
    // Selecting Market
    await tester.tap(item1, warnIfMissed: false);
  }

  Future afterMarketSelected() async {
    await tester.pumpAndSettle();
    expect(symbolDropdown.value, equals(null));
    expect(priceKey.evaluate().length, equals(0));
    expect(symbolDropdown.items?.length ?? 0, greaterThan(0));
    symbolLen = symbolDropdown.items!.length;
    if (symbolDropdown.items?.isNotEmpty ?? false) {
      await tester.tap(drop2);
      await tester.pumpAndSettle();
      final item1 = find
          .byKey(symbolDropdown.items!.elementAt(indexAt(symbolLen)).key!)
          .last;
      await tester.ensureVisible(item1);
      await tester.pumpAndSettle();
      await tester.tap(item1);
      await tester.pumpAndSettle();
      // expect(priceWidget, findsOneWidget);
    }
  }
}

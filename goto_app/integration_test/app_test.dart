import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:goto_app/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Data Fetching', () {
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

  Future checkForIntalized() async {
    await tester.pumpAndSettle();
    var byKeyRefIndicator = find.byKey(const Key('RefreshIndicator'));
    var byKeyDotMenu = find.byKey(const Key('DotMenu'));
    expect(byKeyRefIndicator, findsOneWidget);
    expect(byKeyDotMenu, findsOneWidget);
    await tester.pump(const Duration(seconds: 1));

    await tester.ensureVisible(find.byKey(const Key('RepoBody')));
    await tester.pumpAndSettle();
    // ! Not Required For Test
  }

  ListView get bodyList => tester.widget<ListView>(listView);
  //
  Finder get listView => find.byKey(const Key('RepoBody_ListView'));
  Finder get loadingBody => find.byKey(const Key('Loading'));
}

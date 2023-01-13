import 'package:deriv_test/src/home_page.dart';
import 'package:flutter/cupertino.dart';

/// Define application navigation path constants to avoid duplication
class RoutePaths {
  static const String splash = '/splash';
  static const String homePage = '/home_page';
}

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePaths.homePage:
        return CupertinoPageRoute(
            builder: (context) => const HomePage(),
            settings: const RouteSettings(name: RoutePaths.homePage));

      default:
        // Replace by Empty Page
        return CupertinoPageRoute(
          builder: (context) => Container(),
        );
    }
  }
}

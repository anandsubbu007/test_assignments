import 'package:flutter/material.dart';

class AppService {
  const AppService._();
  static GlobalKey appKey = GlobalKey(debugLabel: 'appKey');
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>(debugLabel: 'navigatorKey');
}

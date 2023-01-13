import 'package:deriv_test/localisation/app_service.dart';
import 'package:deriv_test/navigation/router.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        key: AppService.appKey,
        navigatorKey: AppService.navigatorKey,
        debugShowCheckedModeBanner: false,
        initialRoute: RoutePaths.homePage,
        onGenerateRoute: AppRouter.generateRoute);
  }
}

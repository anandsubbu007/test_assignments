import 'package:flutter/material.dart';
import 'package:pet_adoption_app/src/details/details_pg.dart';
import 'package:pet_adoption_app/src/history/widgets/history.dart';
import 'package:pet_adoption_app/src/home/home.dart';

class Routes {
  static const String homeRoute = '/';
  static const String detailsRoute = '/details';
  static const String historyRoute = '/history';

  static Map<String, WidgetBuilder> getRoute() {
    return <String, WidgetBuilder>{
      /// Home page
      homeRoute: (_) => const Home(),
      /// Details Page
      detailsRoute: (_) => const Details(id: '015'),
      /// History Page
      historyRoute: (_) => const History(),
    };
  }
}

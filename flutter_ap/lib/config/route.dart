import 'package:flutter/material.dart';
import 'package:flutter_ap/presentation/details/details_pg.dart';
import 'package:flutter_ap/presentation/home/home.dart';

class Routes {
  static const String homeRoute = '/';
  static const String detailsRoute = '/details';

  static Map<String, WidgetBuilder> getRoute() {
    return <String, WidgetBuilder>{
      /// Home page
      homeRoute: (_) => const Home(),

      /// Details Page
      detailsRoute: (_) => const Details(id: -1),
    };
  }
}

import 'package:flutter/material.dart';
import 'package:thiran_task/presentation/firebase_list/firebase_listing_pg.dart';
import 'package:thiran_task/presentation/transaction/transaction_form.dart';
import 'package:thiran_task/presentation/firebase_list/firebase_form.dart';
import 'package:thiran_task/presentation/splash/splash_screen.dart';
import 'package:thiran_task/presentation/routers/routes.dart';

import '../transaction/transactions_pg.dart';
import '../github_repos/widgets/github_pagination.dart';
import '../home/home_pg.dart';

class AppRoutes {
  static final routes = {
    Routes.splash: (context) => const SplashScreen(),
    Routes.home: (context) => const HomeScreen(),
    Routes.github: (context) => const GithubListView(),
    Routes.newTransaction: (context) => const NewTransactionPg(),
    Routes.firebase: (context) => const FirebaseScreen(),
    Routes.transactions: (context) => const TransactionListScreen(),
    Routes.firebaseList: (context) => const FirebaseListingPg(),
  };

  static Route<dynamic> errorRoutes(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => Scaffold(
          appBar: AppBar(title: const Text("Error")),
          body: const Center(
            child: Text("Page not found"),
          )),
    );
  }

  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splash:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        );
      case Routes.home:
        return MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        );
      case Routes.github:
        return MaterialPageRoute(builder: (context) => const GithubListView());
      case Routes.newTransaction:
        return MaterialPageRoute(
            builder: (context) => const NewTransactionPg());

      case Routes.transactions:
        return MaterialPageRoute(
            builder: (context) => const TransactionListScreen());

      case Routes.firebaseList:
        return MaterialPageRoute(
            builder: (context) => const FirebaseListingPg());
      default:
        return errorRoutes(settings);
    }
  }
}

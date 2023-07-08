import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thiran_task/application/bloc/firebase/firebase_list_bloc.dart';
import 'package:thiran_task/presentation/home/home_pg.dart';
import 'package:thiran_task/presentation/routers/routes.dart';
import 'package:thiran_task/presentation/routers/routes_generator.dart';

import '../application/bloc/firebase/firebase_bloc.dart';
import '../application/bloc/github/github_bloc.dart';
import '../application/bloc/transaction/transaction_bloc.dart';

class AppHome extends StatelessWidget {
  const AppHome({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (ctx) => TransactionBloc(TransactionInitial())),
          BlocProvider(create: (ctx) => GithubBloc(GithubInitial())),
          BlocProvider(create: (ctx) => FirebaseBloc(FirebaseInitial())),
          BlocProvider(
              create: (ctx) => FirebaseListBloc(FirebaseListInitial())),
        ],
        child: MaterialApp(
          title: 'Thiran Tasks',
          theme: ThemeData(colorSchemeSeed: Colors.blueAccent),
          home: const HomeScreen(),
          initialRoute: Routes.splash,
          onGenerateRoute: AppRoutes.generateRoutes,
          routes: AppRoutes.routes,
        ));
  }
}

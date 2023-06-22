import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_app/bloc/home_bloc.dart';
import 'package:video_app/presentation/video_home.dart';

void main() {
  runApp(_App());
}

class _App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Pet Adoption',
        home: HomeInit());
  }
}

class HomeInit extends StatelessWidget {
  const HomeInit({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      /// Initilizng Home bloc
      value: HomeBloc(),
      child: const HomePg(),
    );
  }
}

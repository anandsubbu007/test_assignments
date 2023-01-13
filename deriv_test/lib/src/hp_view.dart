import 'package:deriv_bloc/deriv_bloc.dart';
import 'package:deriv_test/src/hp_model.dart';
import 'package:deriv_test/src/widgets/home_body.dart';
import 'package:flutter/material.dart';

class HomePageBody extends BasePageViewWidget<HomePageCubit> {
  const HomePageBody(super.bloc, {super.key});

  @override
  Widget build(BuildContext context, model) {
    return StreamBuilder<BaseState>(
        stream: model.stream,
        key: const Key('Stream1'),
        builder: (context, snapshot) {
          final state = snapshot.data;
          if (state is LoadedState) {
            return LoadedBody(model: model);
          } else if (state is ErrorLoadedState) {
            return Center(child: Text('Error: ${state.error}'));
          }
          return const Center(
              key: Key('Loading'), child: CircularProgressIndicator());
        });
  }
}

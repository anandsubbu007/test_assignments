import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goto_app/src/bloc/cubit.dart';
import 'package:goto_app/src/bloc/state.dart';
import 'package:goto_app/src/home/repo_body.dart';
import 'package:goto_app/src/widgets/error.dart';
import 'package:goto_app/src/widgets/loading.dart';
import 'package:goto_app/src/widgets/menu_button.dart';
// import 'package:pull_to_refresh/pull_to_refresh.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        actions: const [DotMenu(key: Key('DotMenu'))],
      ),
      body: const RefreshHandler(child: _Body()),
    );
  }
}

class RefreshHandler extends StatelessWidget {
  final Widget child;
  const RefreshHandler({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      key: const Key('RefreshIndicator'),
      onRefresh: () async {
        await context.read<RepoCubit>().fetchData();
      },
      color: Colors.black,
      child: child,
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    final state = context.watch<RepoCubit>().state;
    if (state is RepoLoading) {
      return const LoadingBody(key: Key('Loading'));
    } else if (state is RepoErrorPg) {
      return ErrorBody(error: state.error);
    } else if (state is RepoOnData) {
      return RepoBody(key: const Key('RepoBody'), datas: state.data);
    }
    return const SizedBox();
  }
}

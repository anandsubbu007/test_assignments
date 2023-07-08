import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thiran_task/presentation/github_repos/widgets/list_tile.dart';
import 'package:thiran_task/presentation/utilities/app_function.dart';

import '../../application/bloc/github/github_bloc.dart';

class GithubScreen extends StatefulWidget {
  const GithubScreen({Key? key}) : super(key: key);

  @override
  State<GithubScreen> createState() => _GithubScreenState();
}

class _GithubScreenState extends State<GithubScreen> {
  ScrollController? controller;

  @override
  void initState() {
    context.read<GithubBloc>().add(PageOnLoadEvent());
    controller = ScrollController()..addListener(_scrollListener);
    super.initState();
  }

  bool loadBottom = false;

  void _scrollListener() {
    if (controller!.offset >= controller!.position.maxScrollExtent &&
        !controller!.position.outOfRange) {
      loadBottom = true;
      setState(() {});
      context.read<GithubBloc>().add(OnGithubListPaginationEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text(
          "Github Repository",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: BlocBuilder<GithubBloc, GithubState>(
          builder: (context, state) {
            if (state is GithubLoaded) {
              return SingleChildScrollView(
                  controller: controller,
                  child: Column(children: [
                    ListView.separated(
                        shrinkWrap: true,
                        primary: false,
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        itemBuilder: (context, index) {
                          return GithubRepoItem(
                            item: state.response.items![index],
                            onTap: () {},
                          );
                        },
                        separatorBuilder: (context, index) =>
                            const Divider(color: Colors.black, height: 3),
                        itemCount: state.response.items!.length),
                    if (loadBottom)
                      const Padding(
                          padding: EdgeInsets.all(10),
                          child: CircularProgressIndicator())
                  ]));
            } else if (state is GithubError) {
              return SizedBox(
                  height: MediaQuery.of(context).size.height / 2,
                  child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(state.error.message!,
                            style: Theme.of(context).textTheme.displayLarge)
                      ]));
            } else {
              return AppFunctions.loadingWidget();
            }
          },
        ),
      ),
    );
  }
}

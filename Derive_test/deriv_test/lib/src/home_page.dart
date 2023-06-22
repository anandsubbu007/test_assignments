import 'package:deriv_bloc/deriv_bloc.dart';
import 'package:deriv_test/src/hp_model.dart';
import 'package:deriv_test/src/hp_view.dart';
import 'package:flutter/material.dart';

class HomePage extends BasePage<HomeViewModel> {
  const HomePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends BaseStatefulPage<HomeViewModel, HomePage> {
  @override
  HomeViewModel get model => HomeViewModel();

  @override
  PreferredSizeWidget? buildAppbar(model) {
    return AppBar(
        leading: const SizedBox(),
        centerTitle: true,
        title: const Text('Price Tracker'));
  }

  @override
  void onModelReady(HomeViewModel model) {
    model.reqData();
    model.listenToSocket();
    super.onModelReady(model);
  }

  @override
  Future<bool> onBackPressed({param}) async {
    return false;
  }

  @override
  Widget buildView(BuildContext context,HomeViewModel model) {
    return HomePageBody(model);
  }
}

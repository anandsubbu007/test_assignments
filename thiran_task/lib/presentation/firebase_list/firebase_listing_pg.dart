// ignore_for_file: use_build_context_synchronously, avoid_print
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thiran_task/application/bloc/firebase/firebase_list_bloc.dart';
import 'package:thiran_task/domain/di/app_preferences.dart';
import 'package:thiran_task/presentation/firebase_list/widget/firebase_details.dart';
import 'package:thiran_task/presentation/firebase_list/widget/firebase_item.dart';
import 'package:thiran_task/presentation/routers/routes.dart';
import '../utilities/app_function.dart';
import '../../../domain/model/firebase_request.dart';

class FirebaseListingPg extends StatefulWidget {
  const FirebaseListingPg({Key? key}) : super(key: key);

  @override
  State<FirebaseListingPg> createState() => _FirebaseListingPgState();
}

class _FirebaseListingPgState extends State<FirebaseListingPg> {
  UserCredential? userCredential;
  @override
  void didChangeDependencies() {
    initData();
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant FirebaseListingPg oldWidget) {
    initData();
    super.didUpdateWidget(oldWidget);
  }

  Future initData() async {
    try {
      if (AppPreferences.instance.userUid == null) {
        userCredential = await FirebaseAuth.instance.signInAnonymously();
        await AppPreferences.instance.setUID(userCredential!.user!.uid);
      }
      context.read<FirebaseListBloc>().add(OnFetchFirebaseEvent());
    } on FirebaseAuthException catch (e) {
      print(e);
      switch (e.code) {
        case "operation-not-allowed":
          print("Anonymous auth hasn't been enabled for this project.");
          break;
        default:
          print("Unknown error.");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Firebase Reports",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Center(
          child: BlocBuilder<FirebaseListBloc, FirebaseListState>(
        bloc: context.read<FirebaseListBloc>(),
        builder: (context, state) {
          if (state is FirebaseListLoaded) {
            return listReportWidget(state.firebaseList);
          } else if (state is FirebaseListError) {
            return errorWidget(state);
          } else {
            return AppFunctions.loadingWidget();
          }
        },
      )),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.blueAccent,
        onPressed: () async {
          await Navigator.pushNamed(context, Routes.firebase);
          initData();
        },
        label: const Text('New Ticket'),
      ),
    );
  }

  Widget errorWidget(FirebaseListError state) {
    return Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(state.error.toString()),
        ]);
  }

  Widget listReportWidget(List<FirebaseRequest> list) {
    if (list.isNotEmpty) {
      return ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          itemBuilder: (context, index) {
            return FirebaseItem(
              item: list[index],
              onTap: () {
                showModalBottomSheet<void>(
                  context: context,
                  enableDrag: false,
                  isDismissible: false,
                  backgroundColor: Colors.transparent,
                  shape: const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(25.0)),
                  ),
                  builder: (BuildContext context) {
                    return FirebaseDetailScreen(item: list[index]);
                  },
                );
              },
            );
          },
          separatorBuilder: (context, index) => Container(),
          itemCount: list.length);
    } else {
      return const Center(child: Text("No Records Found"));
    }
  }
}

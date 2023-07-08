import 'package:flutter/material.dart';
import 'package:thiran_task/presentation/widgets/filled_button.dart';

import '../routers/routes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leadingWidth: 0,
          centerTitle: true,
          leading: const SizedBox(),
          title: const Text("Interview Tasks")),
      body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FilledAppButton(
                  label: "Transaction Screen",
                  margin: const EdgeInsets.only(top: 16),
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.transactions);
                  }),
              const SizedBox(height: 20),
              FilledAppButton(
                label: "Github Repositories",
                margin: const EdgeInsets.only(top: 16),
                onPressed: () {
                  Navigator.pushNamed(context, Routes.github);
                },
              ),
              const SizedBox(height: 20),
              FilledAppButton(
                label: "Firebase Reports",
                margin: const EdgeInsets.only(top: 16),
                onPressed: () {
                
                  Navigator.pushNamed(context, Routes.firebaseList);
                },
              ),
              const SizedBox(height: 30),
            ],
          )),
    );
  }
}

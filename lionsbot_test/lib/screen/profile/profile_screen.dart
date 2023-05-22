// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lionsbot_test/screen/profile/components/home_bottombar.dart';
import 'package:lionsbot_test/screen/profile/components/profile_appbar.dart';
import 'package:lionsbot_test/screen/profile/components/profile_insights.dart';
import 'package:lionsbot_test/screen/profile/components/profile_widgets.dart';

import '../../controller/auth_controller.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  AuthController authController = Get.put(AuthController());

  late TextTheme textTheme;
  @override
  void didChangeDependencies() {
    textTheme = Theme.of(context).textTheme;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      length: 5,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: PreferredSize(
            preferredSize: Size(double.infinity, 60), child: ProfileAppBar()),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          // padding: EdgeInsets.zero,
          children: <Widget>[
            ProfileAvatar(),
            ProfileTitle(),
            Expanded(child: ProfileInsights()),
          ],
        ),
        bottomNavigationBar: BottomNavBar(),
      ),
    );
  }
}

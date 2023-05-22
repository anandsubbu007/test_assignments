import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lionsbot_test/controller/auth_controller.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({super.key});
  final double coverHeight = 220;
  final double profileHeight = 144;

  @override
  Widget build(BuildContext context) {
    final double top = coverHeight - profileHeight / 1.45;
    final double bottom = profileHeight / 2.5;
    AuthController authController = Get.put(AuthController());
    Widget buildCoverBackground() => Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [Colors.pinkAccent, Colors.blue],
        )),
        width: double.infinity,
        height: coverHeight);
    Widget buildProfileImage() => Container(
          padding: const EdgeInsets.all(5),
          decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    offset: Offset(-1, -1),
                    color: Colors.black45,
                    spreadRadius: 1,
                    blurRadius: 1)
              ],
              shape: BoxShape.circle),
          child: CircleAvatar(
              backgroundColor: Colors.grey.shade800,
              backgroundImage: NetworkImage(authController.authService.profile),
              radius: profileHeight / 2),
        );
    return Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Container(
              margin: EdgeInsets.only(bottom: bottom),
              child: buildCoverBackground()),
          Positioned(top: top, child: buildProfileImage()),
        ]);
  }
}

class ProfileTitle extends StatelessWidget {
  const ProfileTitle({super.key});

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.put(AuthController());
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        const SizedBox(height: 5),
        GradientText(
          authController.authService.name,
          style: textTheme.titleLarge!.copyWith(fontSize: 30),
          colors: const [Colors.blue, Colors.purple, Colors.orange],
        ),
        const SizedBox(height: 3),
        Text('Cleaning Hours : 18', style: textTheme.labelLarge!.copyWith()),
      ],
    );
  }
}

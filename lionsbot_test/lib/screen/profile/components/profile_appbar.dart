import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lionsbot_test/controller/auth_controller.dart';

class ProfileAppBar extends StatelessWidget {
  const ProfileAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.put(AuthController());
    final textTheme = Theme.of(context).textTheme;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {},
              child: Text("Home  ",
                  style: textTheme.bodyMedium!.copyWith(color: Colors.white)),
            ),
            Expanded(
              child: Text(
                "Profile",
                textAlign: TextAlign.center,
                style: textTheme.headlineSmall!
                    .copyWith(fontWeight: FontWeight.w600, color: Colors.white),
              ),
            ),
            TextButton(
              onPressed: () {
                authController.logout();
              },
              child: Text("Logout",
                  style: textTheme.bodyMedium!.copyWith(color: Colors.white)),
            )
          ],
        ),
      ),
    );
  }
}

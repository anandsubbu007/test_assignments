import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:lionsbot_test/db/rest_data.dart';
import '../screen/login_screen.dart';
import '../screen/profile/profile_screen.dart';

class AuthenticationService extends GetxService {
  bool isLogged = false;
  late String name;
  late String username;
  late String profile;

  void logOut() {
    isLogged = false;
  }


  void login(String username, String password) async {
    final user = await RestData().login(username, password);
    if (user == null) {
      Fluttertoast.showToast(
          msg: "Invalid UserName or Password",
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.red,
          textColor: Colors.white);
      return;
    }
    var usr = user;
    name = usr.name;
    username = usr.username;
    profile = usr.pic;
    isLogged = true;
    Get.to(() => const ProfileScreen());
  }

  void processLogout() {
    logOut();
    Get.offAll(() => const LoginScreen());
  }
}

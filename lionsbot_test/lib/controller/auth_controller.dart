import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../service/authentication_service.dart';

class AuthController extends GetxController {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  AuthenticationService authService = Get.put(AuthenticationService());

  void login() async {
    String username = usernameController.text;
    String password = passwordController.text;
    authService.login(username, password);
  }

  void logout() async {
    usernameController.text = '';
    passwordController.text = '';
    authService.processLogout();
  }
}

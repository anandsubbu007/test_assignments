import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../service/authentication_service.dart';

class AuthController extends GetxController {
  TextEditingController usernameController =
      TextEditingController(text: kDebugMode ? 'Anand' : '');
  TextEditingController passwordController =
      TextEditingController(text: kDebugMode ? '123456' : '');
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

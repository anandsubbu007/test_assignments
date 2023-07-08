import 'package:flutter/material.dart';
import 'package:thiran_task/domain/di/app_preferences.dart';
import 'package:thiran_task/infrastructure/fcm/fcm_handler.dart';
import 'package:thiran_task/presentation/app_home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppPreferences.instance.init();
  await AppFcmHandler.instance.firebaseInit();
  runApp(const AppHome());
}

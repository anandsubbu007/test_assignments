import 'package:flutter/material.dart';
// import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../domain/di/app_preferences.dart';
export 'extensions.dart';

class AppFunctions {
  AppFunctions._();
  static Widget loadingWidget() {
    return const Center(
        child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [CircularProgressIndicator()]));
  }

  // static sendTransaction(
  //     {String body = "",
  //     String subject = "",
  //     String recipients = "",
  //     String cc = "",
  //     String bcc = ""}) async {
  //   final Email email = Email(
  //     body: body,
  //     subject: subject,
  //     recipients: ['anandsubbu0@gmail.com'],
  //     cc: ['cc@example.com'],
  //     bcc: ['bcc@example.com'],
  //     attachmentPaths: [],
  //     isHTML: false,
  //   );

  //   await FlutterEmailSender.send(email);
  // }

  static Future<void> requestPermission(Permission permission) async {
    PermissionStatus status = await permission.status;
    if (status.isPermanentlyDenied) {
      openAppSettings();
    }
    if (!status.isGranted) {
      await permission.request();
    }
  }

  static getDateMonthBefore() {
    return DateFormat("yyyy-MM-dd")
        .format(DateTime.now().subtract(const Duration(days: 30)));
  }

  static getUrl() {
    if (AppPreferences.instance.nextPageUrl != null &&
        AppPreferences.instance.nextPageUrl!.isNotEmpty) {
      return AppPreferences.instance.nextPageUrl!;
    } else {
    // https://api.github.com/search/repositories?q=created:>2022-04-29&sort=stars&order=desc
      return "https://api.github.com/search/repositories?q=created:%3E${getDateMonthBefore()}&sort=stars&order=desc&page=0";
    }
  }
}

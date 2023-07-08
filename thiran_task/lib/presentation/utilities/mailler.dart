// ignore_for_file: prefer_interpolation_to_compose_strings, avoid_print, prefer_const_constructors

import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:thiran_task/domain/di/app_preferences.dart';

class AppMailier {
  static Future triggerMail() async {
    String username = 'username@gmail.com';
    String password = 'password';

    final smtpServer = gmail(username, password);
    // Use the SmtpServer class to configure an SMTP server:
    // final smtpServer = SmtpServer('smtp.domain.com');
    // See the named arguments of SmtpServer for further configuration
    // options.

    // Create our message.
    final message = Message()
      ..from = Address(username, 'Anand')
      ..recipients.add('anandsubbu0@gmail.com')
      ..ccRecipients.addAll(['destCc1@example.com'])
      ..subject = 'Test Dart Mailer library :: 😀 :: ${DateTime.now()}'
      ..text = 'This is the plain text.\nThis is line 2 of the text part.'
      ..html = "<h1>Test</h1>\n<p>Hey! Here's some HTML content</p>";

    try {
      final sendReport = await send(message, smtpServer);
      await AppPreferences.instance.setLastPushMailTime(DateTime.now());
      print('Message sent: ' + sendReport.toString());
    } on MailerException catch (e) {
      print('Message not sent.');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
  }
}

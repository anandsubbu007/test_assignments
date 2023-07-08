// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:thiran_task/domain/di/app_preferences.dart';
import 'package:thiran_task/domain/model/firebase_request.dart';

class FirebaseRepository {
  FirebaseRepository();

  Future<dynamic> requestFCM(FirebaseRequest request) async {
    final response =
        await http.post(Uri.parse("https://fcm.googleapis.com/fcm/send"),
            body: jsonEncode({
              "content-available": 1,
              "registration_ids": [AppPreferences.instance.notificationToken],
              "collapse_key": null,
              "notification": {
                "title": request.title,
                "body": "Request has been created",
              },
              "data": request.toJson(),
              "priority": 10
            }),
            headers: {
          "Authorization":
              "key=AAAA60stL48:APA91bFjcjhDUkuZBQWMBQB5zcyNm6tvtx--XoPXyfbhPQBW63uGlCnAmDvt0QwJ_8AEpzKBLsve8l6cuB5oAvpYrv97JIBzkehBuAF-cctKNwE7VprspEVt0ViR1Y_BWBAhWB67mBeQ",
          "Content-Type": 'application/json'
        });
    print(response.body);
  }
}

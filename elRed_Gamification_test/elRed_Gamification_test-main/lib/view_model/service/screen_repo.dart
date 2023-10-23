import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/model/models/screen_model.dart';
import 'package:flutter_app/view_model/service/manual_data.dart';
import 'package:http/http.dart' as http;

/// Repositery
class Repo {
  /// Http Client
  final http.Client client;
  Repo(this.client);

  /// Getting Screen Data
  Future<List<Screen>> getData() async {
    try {
      final datas = [...(screenData['screens'] as List)]
          .map((e) => Screen.fromMap(e))
          .toList();
      return datas;
    } catch (e) {
      debugPrint(e.toString());
      return Future.error(e);
    }
  }

  /// Submitting data
  Future submitData(List<Screen> screens) async {
    Map<String, String> datas = {
      'name': "",
      'gender': "",
      'dob': "",
      'profession': "",
      'skills': ""
    };
    for (var e in screens) {
      if (e.ans == null) {
        return Future.error("Answer not found for screen ${e.screen_name}");
      }
      if (datas.keys.contains(e.screen_name)) {
        datas[e.screen_name] = e.ans!;

        /// Skills in Screen Not FOund. So Using technology as Skills
      } else if (e.screen_name == "technology") {
        datas['skills'] = e.ans!;
      }
    }
    debugPrint(jsonEncode(datas));
    final uri = Uri.parse("https://test1.elred.io/postUserInformation");
    try {
      final http.Response response = await client.post(
        uri,
        // body: datas,
        body: jsonEncode(datas),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      debugPrint(response.body.toString());
      if (response.statusCode != 200) {
        return Future.error(jsonDecode(response.body)['message']);
      }
      debugPrint(response.body.toString());
      final body = json.decode(response.body);
      if (body["success"] == true || body["status"] == "success") {
        return true;
      }
    } catch (err) {
      return Future.error(err);
    }
  }
  // { success : true, message : " user details updated successfully", result : [ Result Object ] }
}

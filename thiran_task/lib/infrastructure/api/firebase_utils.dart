// ignore_for_file: avoid_print

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:thiran_task/domain/di/app_preferences.dart';
import 'package:thiran_task/domain/model/firebase_request.dart';

class FirebaseUtils {
  FirebaseUtils._();

  static final FirebaseStorage _storage = FirebaseStorage.instance;
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  static Future<String> uploadPic(File image) async {
    Reference ref = _storage.ref().child("image${DateTime.now()}");
    UploadTask uploadTask = ref.putFile(image);
    var reference = uploadTask.storage.ref();
    return await reference.getDownloadURL();
  }

  static Future<dynamic> uploadPicture(File image) async {
    TaskSnapshot snapshot = await FirebaseStorage.instance
        .ref("image${DateTime.now()}")
        .putFile(File(image.path));
    if (snapshot.state == TaskState.success) {
      print("Image uploaded Successful");
      return await snapshot.ref.getDownloadURL();
    } else if (snapshot.state == TaskState.running) {
      // Show Prgress indicator
    } else if (snapshot.state == TaskState.error) {
      // Handle Error Here
    }
  }

  static Future<dynamic> saveBugReport(
      FirebaseRequest request, String userId) async {
    try {
      final userProfileRef = _db.collection("bugs").doc();
      await userProfileRef.set(request.toJson(), SetOptions(merge: true));
      return true;
    } catch (e) {
      return e.toString();
    }
  }

  static Future<dynamic> getBugReport() async {
    List<FirebaseRequest> datas = [];
    if (AppPreferences.instance.userUid == null) return;
    try {
      final querySnapshot = await _db
          .collection("bugs")
          .where("uid", isEqualTo: AppPreferences.instance.userUid)
          .get();
      for (var docSnapshot in querySnapshot.docs) {
        datas.add(FirebaseRequest.fromJson(docSnapshot.data()));
      }
      return datas;
    } catch (e) {
      return e.toString();
    }
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:get/get.dart';

import 'models/user.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;
  final List<User> _users = [
    User("Anand", "Anand", "123456",
        "https://images.pexels.com/photos/771742/pexels-photo-771742.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"),
    User("Subbu", "Subbu", "123456", ""),
  ];

  DatabaseHelper.internal();
  Future<User?> getUser(String username) async {
    final user = _users.firstWhereOrNull((e) => e.username == username);
    return user;
  }

  Future<User?> checkUser(String username, String password) async {
    final user = _users.firstWhereOrNull(
        (e) => e.username == username && e.password == password);
    return user;
  }

  Future<List<User>> getAllUser() async {
    return _users;
  }
}

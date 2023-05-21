import 'dart:async';

import 'package:get/get.dart';

import 'user.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;
  final List<User> _users = [
    User("Anand", "Anand", "123456", ""),
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

// ignore_for_file: depend_on_referenced_packages

import 'dart:developer';
import 'dart:io' as io;

import 'package:employee_app/infrastructure/db_utils/db_constants.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

// Db Singleton Object to hold Database Instance
class AppDB {
  static final AppDB _instance = AppDB.internal();

  factory AppDB() => _instance;
  static Database? _db;
  AppDB.internal();

  Database get db => _db!;

  /// Intalizing DB
  ///
  /// This will create DB in Local App
  Future<void> init() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DbConst.db);
    _db = await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    try {
      await db.execute(DbConst.createTblEmployeeQuery);
    } catch (e) {
      log(e.toString());
    }
  }
}

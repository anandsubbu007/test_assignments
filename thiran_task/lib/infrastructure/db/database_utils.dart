import 'dart:async';
import 'dart:io';

// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../../domain/model/transaction_model.dart';

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    // if _database is null we instantiate it
    _database = await initDB();
    return _database!;
  }

  Future<Database> initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "trans_db.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute(
          "CREATE TABLE trans (transaction_id TEXT PRIMARY KEY,transaction_desc TEXT,transaction_status TEXT,transaction_datetime TEXT)");
    });
  }

  Future newTransaction(TransactionM data) async {
    final db = await database;
    var raw = await db.rawInsert(
        "INSERT Into trans (transaction_id,transaction_desc,transaction_status,transaction_datetime)"
        " VALUES (?,?,?,?)",
        [
          data.transactionId,
          data.transactionDesc,
          data.transactionStatus,
          data.transactionDatetime,
        ]);
    return raw;
  }

  Future<TransactionM?> getTransaction(String id) async {
    final db = await database;
    var res = await db.query("trans", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? TransactionM.fromJson(res.first) : null;
  }

  Future<TransactionM?> getTransactionByStatus(String status) async {
    final db = await database;
    var res = await db.query("trans",
        where: "transaction_status = ?", whereArgs: [status]);
    return res.isNotEmpty ? TransactionM.fromJson(res.first) : null;
  }

  Future<List<TransactionM>> getAllTransaction() async {
    try {
      final db = await database;
      var res = await db.query("trans");
      List<TransactionM> list = res.isNotEmpty
          ? res.map((c) => TransactionM.fromJson(c)).toList()
          : [];
      return list;
    } catch (e) {
      return [];
    }
  }

  Future<Future<int>> deleteTransaction(String id) async {
    final db = await database;
    return db.delete("trans", where: "id = ?", whereArgs: [id]);
  }

  Future<Future<int>> deleteAll() async {
    final db = await database;
    return db.delete("trans");
  }
}

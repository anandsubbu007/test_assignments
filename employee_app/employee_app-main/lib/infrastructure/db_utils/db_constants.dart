class DbConst {
  static const String db = "database.db";

  // Table names
  static const String tblEmployee = "TblEmployee";

  // Queries
  static const String createTblEmployeeQuery =
      "CREATE TABLE $tblEmployee (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, role TEXT, fromDate TEXT, toDate TEXT)";
}

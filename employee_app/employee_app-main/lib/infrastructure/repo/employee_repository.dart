import 'package:employee_app/domain/model/employee_data.dart';
import 'package:employee_app/infrastructure/db_utils/db_constants.dart';
import 'package:employee_app/infrastructure/db_utils/db_helper.dart';
import 'package:injectable/injectable.dart';

import '../../domain/model/helper/output.dart';

@Singleton()
class EmployeeRepository {
  AppDB dbHelper = AppDB.internal();

  Future<Output> upsert(EmployeeM data) async {
    Output output = Output();
    try {
      final id = data.id == null
          ? await dbHelper.db.insert(DbConst.tblEmployee, data.toJson())
          : await dbHelper.db.update(DbConst.tblEmployee, data.toJson(),
              where: "id = ?", whereArgs: [data.id]);
      if (id > 0) output.isSuccess = true;
    } catch (e) {
      output.errorMessage = e.toString();
      output.isSuccess = false;
      output.message = "Error on Saving Employee Data";
    }
    return output;
  }

  Future<Output> delete(int employeeId) async {
    Output output = Output();

    try {
      final id = await dbHelper.db.delete(DbConst.tblEmployee,
          where: "id = ?", whereArgs: [employeeId]);
      if (id > 0) output.isSuccess = true;
    } catch (e) {
      output.errorMessage = e.toString();
      output.isSuccess = false;
      output.message = "Error on Deleting Employee";
    }

    return output;
  }

  Future<List<EmployeeM>> getAll() async {
    List<EmployeeM> data = [];
    try {
      final vouchers =
          await dbHelper.db.rawQuery("SELECT * FROM ${DbConst.tblEmployee}");
      List<EmployeeM> pros =
          vouchers.map((data) => EmployeeM.fromJson(data)).toList();
      if (pros.isNotEmpty) data = pros;
    } catch (_) {}
    return data;
  }
}

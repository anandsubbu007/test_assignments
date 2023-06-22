import 'package:freezed_annotation/freezed_annotation.dart';
part 'employee_status.freezed.dart';

@freezed
class EmployeeStatus with _$EmployeeStatus {
  const factory EmployeeStatus() = _EmployeeStatus;
  const factory EmployeeStatus.added() = _Added;
  const factory EmployeeStatus.edited() = _Edited;
  const factory EmployeeStatus.fetched() = _Fetched;
  const factory EmployeeStatus.deleted() = _Deleted;
  const factory EmployeeStatus.undoDelete() = _UndoDelete;
  const factory EmployeeStatus.failed() = _Failed;
}

part of 'employee_bloc.dart';

@freezed
class EmployeeEvent with _$EmployeeEvent {
  const factory EmployeeEvent.upsertEmployee({required EmployeeM data}) =
      UpsertEmployee;
  const factory EmployeeEvent.getEmployees() = GetEmployees;
  const factory EmployeeEvent.deleteEmployee({required EmployeeM data}) =
      DeleteEmployee;
  const factory EmployeeEvent.undoDelete() = UndoDelete;
}

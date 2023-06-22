part of 'employee_bloc.dart';

@freezed
class EmployeeState with _$EmployeeState {
  const factory EmployeeState({
    required List<EmployeeM> currentEmployees,
    required List<EmployeeM> previousEmployees,
    required EmployeeStatus status,
    required String errorMessage,
    required EmployeeM? lastDeleteData,
  }) = _EmployeeState;

  factory EmployeeState.initial() {
    return const EmployeeState(
      status: EmployeeStatus(),
      currentEmployees: [],
      previousEmployees: [],
      errorMessage: "",
      lastDeleteData: null,
    );
  }
}

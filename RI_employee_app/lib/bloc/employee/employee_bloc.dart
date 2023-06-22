import 'package:employee_app/domain/status/employee_status.dart';
import 'package:employee_app/infrastructure/repo/employee_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/model/employee_data.dart';

part 'employee_bloc.freezed.dart';
part 'employee_event.dart';
part 'employee_state.dart';

@injectable
class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
  final EmployeeRepository _employeeRepo;
  EmployeeBloc(this._employeeRepo) : super(EmployeeState.initial()) {
    // Upsert Employee
    on<UpsertEmployee>((event, emit) async {
      emit(state.copyWith(status: const EmployeeStatus()));
      final isNew = event.data.id == null;

      final response = await _employeeRepo.upsert(event.data);

      if (response.isSuccess) {
        add(const GetEmployees());
        emit(state.copyWith(
            status: isNew
                ? const EmployeeStatus.added()
                : const EmployeeStatus.edited()));
      } else {
        emit(state.copyWith(
            status: const EmployeeStatus.failed(),
            errorMessage: response.message));
      }
    });

    // Delete Employee
    on<DeleteEmployee>((event, emit) async {
      emit(state.copyWith(
          lastDeleteData: event.data, status: const EmployeeStatus()));
      final response = await _employeeRepo.delete(event.data.id!);

      if (response.isSuccess) {
        add(const GetEmployees());
        emit(state.copyWith(status: const EmployeeStatus.deleted()));
      } else {
        emit(state.copyWith(
            status: const EmployeeStatus.failed(),
            errorMessage: response.message));
      }
    });

    // Undo Employee Delete
    on<UndoDelete>((event, emit) async {
      emit(state.copyWith(status: const EmployeeStatus()));
      final data = state.lastDeleteData!;
      data.id = null;
      final response = await _employeeRepo.upsert(data);
      if (response.isSuccess) {
        add(const GetEmployees());
        emit(state.copyWith(status: const EmployeeStatus.undoDelete()));
      } else {
        emit(state.copyWith(
            status: const EmployeeStatus.failed(),
            errorMessage: response.message));
      }
    });

    // Get All Employees
    on<GetEmployees>((event, emit) async {
      final response = await _employeeRepo.getAll();
      final newState = state.copyWith(
        currentEmployees: response.where((e) => !e.isPreviousEmployee).toList(),
        previousEmployees: response.where((e) => e.isPreviousEmployee).toList(),
        status: const EmployeeStatus.fetched(),
      );
      emit(newState);
    });
  }
}

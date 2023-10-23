import 'package:freezed_annotation/freezed_annotation.dart';
part 'employee_data.g.dart';

@JsonSerializable()
class EmployeeM {
  int? id;
  String name;
  String role;
  DateTime fromDate;
  DateTime? toDate;

  EmployeeM({
    this.id,
    required this.fromDate,
    this.name = "",
    this.role = "",
    this.toDate,
  });

  factory EmployeeM.fromJson(Map<String, dynamic> json) =>
      _$EmployeeDataFromJson(json);

  Map<String, dynamic> toJson() => _$EmployeeDataToJson(this);

  bool get isPreviousEmployee => toDate?.isBefore(DateTime.now()) ?? false;
}

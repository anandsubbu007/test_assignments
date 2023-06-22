// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmployeeM _$EmployeeDataFromJson(Map<String, dynamic> json) => EmployeeM(
      id: json['id'] as int?,
      fromDate: DateTime.parse(json['fromDate'] as String),
      name: json['name'] as String? ?? "",
      role: json['role'] as String? ?? "",
      toDate: json['toDate'] == null
          ? null
          : DateTime.parse(json['toDate'] as String),
    );

Map<String, dynamic> _$EmployeeDataToJson(EmployeeM instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'role': instance.role,
      'fromDate': instance.fromDate.toIso8601String(),
      'toDate': instance.toDate?.toIso8601String(),
    };

import 'package:employee_app/bloc/employee/employee_bloc.dart';
import 'package:employee_app/domain/model/employee_data.dart';
import 'package:employee_app/domain/status/employee_status.dart';
import 'package:employee_app/presentation/src/widgets/role_selection_sheet.dart';
import 'package:employee_app/presentation/widgets/app_date_picker.dart';
import 'package:employee_app/presentation/widgets/app_textfield.dart';
import 'package:employee_app/presentation/widgets/footer_btn.dart';
import 'package:employee_app/utils/constant/assets.dart';
import 'package:employee_app/utils/extensions/date_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

/// Employee Form Page
class EmployeeFormPg extends StatelessWidget {
  final EmployeeM? employee;
  const EmployeeFormPg({super.key, this.employee});

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameCtrl = TextEditingController();
    final TextEditingController fromDateCtrl = TextEditingController();
    final TextEditingController toDateCtrl = TextEditingController();
    final TextEditingController roleCtrl = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    DateTime fromDate = employee?.fromDate ?? DateTime.now();
    DateTime? toDate = employee?.toDate;
    bool isNew = employee?.id == null;
    nameCtrl.text = employee?.name ?? '';
    roleCtrl.text = employee?.role ?? '';
    fromDateCtrl.text = fromDate.toReadableDate;
    toDateCtrl.text = toDate?.toDMMMY ?? '';

    return BlocListener<EmployeeBloc, EmployeeState>(
      listener: (ctx, state) {
        if (state.status == const EmployeeStatus.added()) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Employee Added")));
        } else if (state.status == const EmployeeStatus.edited()) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Employee Edited")));
        } else if (state.status == const EmployeeStatus.failed()) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.errorMessage)));
        } else if (state.status == const EmployeeStatus.deleted()) {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          elevation: 0,
          centerTitle: false,
          automaticallyImplyLeading: false,
          title: const Text(
            "Add Employee Details",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          actions: !isNew
              ? [
                  IconButton(
                      onPressed: () {
                        context
                            .read<EmployeeBloc>()
                            .add(DeleteEmployee(data: employee!));
                      },
                      icon: SvgPicture.asset(
                        AppIcons.icDelete
                      ))
                ]
              : null,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      AppTextField(
                        label: "Employee name",
                        controller: nameCtrl,
                        icon: SvgPicture.asset(AppIcons.icPerson),
                        validator: (value) => value.isNotEmpty,
                      ),
                      const SizedBox(height: 10),
                      AppTextField(
                        label: "Select role",
                        controller: roleCtrl,
                        readOnly: true,
                        validator: (value) => value.isNotEmpty,
                        onTap: () {
                          RoleSelectionSheet(
                            onSelected: (value) => roleCtrl.text = value,
                          ).callSheet(context);
                        },
                        icon: SvgPicture.asset(AppIcons.icRole),
                        suffixIcon: SvgPicture.asset(AppIcons.icDropDown),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: AppTextField(
                              label: "No Date",
                              controller: fromDateCtrl,
                              readOnly: true,
                              icon: SvgPicture.asset(AppIcons.icDate),
                              validator: (value) {
                                return value.isNotEmpty;
                              },
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => AppDatePicker(
                                    isOptional: false,
                                    selectedDate: fromDate,
                                    onSelected: (dateTime) {
                                      fromDate = dateTime;
                                      fromDateCtrl.text = fromDate.toDMMMY;
                                    },
                                  ),
                                );
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, top: 10),
                            child: SvgPicture.asset(AppIcons.icArrow),
                          ),
                          Expanded(
                            child: AppTextField(
                              label: "No Date",
                              readOnly: true,
                              controller: toDateCtrl,
                              icon: SvgPicture.asset(
                                AppIcons.icDate,
                              ),
                              onTap: () {
                                if (fromDateCtrl.text.isNotEmpty) {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AppDatePicker(
                                      isOptional: true,
                                      startDate: fromDate,
                                      selectedDate: toDate,
                                      onSelected: (dateTime) {
                                        toDate = dateTime;
                                        toDateCtrl.text = toDate?.toDMMMY ?? '';
                                      },
                                    ),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              "Please select start date")));
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 5, 12, 15),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ActionButton(
                    title: employee?.id == null ? "Cancel" : "Back",
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    fontColor: Colors.blue,
                    color: Colors.blue.withOpacity(.12),
                  ),
                  const SizedBox(width: 10),
                  ActionButton(
                    title: "Save",
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        final data = EmployeeM(
                          id: employee?.id,
                          name: nameCtrl.text,
                          fromDate: fromDate,
                          role: roleCtrl.text,
                          toDate: toDate,
                        );
                        context
                            .read<EmployeeBloc>()
                            .add(UpsertEmployee(data: data));
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

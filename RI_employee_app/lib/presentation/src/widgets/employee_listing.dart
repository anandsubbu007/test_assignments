import 'package:employee_app/bloc/employee/employee_bloc.dart';
import 'package:employee_app/domain/model/employee_data.dart';
import 'package:employee_app/utils/constant/app_colors.dart';
import 'package:employee_app/utils/constant/assets.dart';
import 'package:employee_app/utils/extensions/date_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';

import '../employee_form_pg.dart';

class EmployeeListBuilder extends StatelessWidget {
  const EmployeeListBuilder({super.key, required this.data});
  final List<EmployeeM> data;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: data.length,
      itemBuilder: (context, index) {
        return EmployeeListTile(data: data[index]);
      },
    );
  }
}

class EmployeeListTile extends StatelessWidget {
  final EmployeeM data;
  const EmployeeListTile({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return SwipeActionCell(
      isDraggable: true,
      backgroundColor: Colors.transparent,
      key: ObjectKey(data.id),
      trailingActions: <SwipeAction>[
        SwipeAction(
            icon: SvgPicture.asset(
              AppIcons.icDelete,
              height: 25,
            ),
            onTap: (CompletionHandler handler) async {
              context.read<EmployeeBloc>().add(DeleteEmployee(data: data));
            },
            color: Colors.red),
      ],
      child: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (ctx) => EmployeeFormPg(
                  employee: data,
                ),
              ));
        },
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 15,
          ),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                  bottom: BorderSide(
                color: AppColors.borderGrey.withOpacity(.3),
              ))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data.name,
                maxLines: 1,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                data.role,
                maxLines: 1,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                !data.isPreviousEmployee
                    ? "From ${data.fromDate.toDMMMY}"
                    : "${data.fromDate.toDMMMY} - ${data.toDate?.toDMMMY ?? ''}",
                maxLines: 1,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

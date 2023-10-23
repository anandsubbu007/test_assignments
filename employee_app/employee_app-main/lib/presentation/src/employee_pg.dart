import 'package:employee_app/domain/status/employee_status.dart';
import 'package:employee_app/presentation/src/employee_form_pg.dart';
import 'package:employee_app/presentation/src/widgets/employee_listing.dart';
import 'package:employee_app/presentation/src/widgets/no_data.dart';
import 'package:employee_app/presentation/src/widgets/title_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/employee/employee_bloc.dart';

/// Home page for Employee Listing
class EmployeePg extends StatelessWidget {
  const EmployeePg({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<EmployeeBloc, EmployeeState>(
      listener: (context, state) {
        if (state.status == const EmployeeStatus.deleted()) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: const FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Text("Employee data has been deleted", maxLines: 1)),
            action: SnackBarAction(
              label: "Undo",
              onPressed: () {
                context.read<EmployeeBloc>().add(const UndoDelete());
              },
            ),
          ));
        } else if (state.status == const EmployeeStatus.undoDelete()) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Restored Deleted Employee"),
          ));
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.blue,
          elevation: 0,
          centerTitle: false,
          title: const Text(
            "Employee List",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
        ),
        body: BlocBuilder<EmployeeBloc, EmployeeState>(
          builder: (ctx, state) {
            if (state.currentEmployees.isEmpty &&
                state.previousEmployees.isEmpty) {
              return const NoDataWidget();
            } else {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (state.currentEmployees.isNotEmpty)
                      const TitleWidget(title: "Current employees"),
                    EmployeeListBuilder(data: state.currentEmployees),
                    if (state.previousEmployees.isNotEmpty)
                      const TitleWidget(title: "Previous employees"),
                    EmployeeListBuilder(data: state.previousEmployees),
                    Container(
                      color: Colors.grey[100],
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 15),
                      child: const Text(
                        "Swipe left to delete",
                        style: TextStyle(fontSize: 15, color: Colors.grey),
                      ),
                    ),
                    const SizedBox(height: 50),
                  ],
                ),
              );
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (ctx) => const EmployeeFormPg(),
                ));
          },
          elevation: 0,
          mini: true,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

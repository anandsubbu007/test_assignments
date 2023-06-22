import 'package:employee_app/utils/constant/assets.dart';
import 'package:employee_app/bloc/employee/employee_bloc.dart';
import 'package:employee_app/presentation/src/employee_pg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Splash Screen for Application 
class SplashScreenPg extends StatelessWidget {
  const SplashScreenPg({super.key});

  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      context.read<EmployeeBloc>().add(const GetEmployees());
      await Future.delayed(const Duration(seconds: 2), () {
        if (context.mounted) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (ctx) => const EmployeePg()));
        }
      });
    });
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Image.asset(AppIcons.launcherIcon, height: 180),
        ));
  }
}

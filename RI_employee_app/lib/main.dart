import 'package:device_preview/device_preview.dart';
import 'package:employee_app/bloc/employee/employee_bloc.dart';
import 'package:employee_app/domain/di/injectable.dart';
import 'package:employee_app/infrastructure/db_utils/db_helper.dart';
import 'package:employee_app/presentation/splash/splash_pg.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dependenciesInit();
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  /// Intalizing DB
  await AppDB().init();
  runApp(
    // to checck abaptability for various devices
    DevicePreview(
      // enabled: false,
      enabled: kDebugMode,
      builder: (ctx) => const MyApp(),
    ),
  );
}
/// Starting Point of Application 
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (ctx) => getIt<EmployeeBloc>(),
      child: MaterialApp(
        title: 'Employees',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const SplashScreenPg(),
      ),
    );
  }
}

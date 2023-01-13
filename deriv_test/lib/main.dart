import 'package:deriv_model/di.dart';
import 'package:deriv_test/app.dart';
import 'package:flutter/material.dart';
import 'dependencies.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies(DependencyConfigurationContext());
  runApp(const MyApp());
}
 
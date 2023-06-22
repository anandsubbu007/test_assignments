import 'package:deriv_data/deriv_data.dart';
import 'package:deriv_test/di/config.dart';
import 'package:get_it/get_it.dart';
import 'package:deriv_model/di.dart';

final getIt = GetIt.instance;

// configureModulesDependencies imported from feature_module
final configurators = [
  AppDependencyConfigurator(),
  NetworkDependencyConfigurator(),
];

Future configureDependencies(DependencyConfigurationContext context) async {
  for (var configurator in configurators) {
    await configurator.configureDependencies(context, getIt);
  }
}

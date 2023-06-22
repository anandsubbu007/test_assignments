import 'package:get_it/get_it.dart';

abstract class DependencyConfigurator {
  Future configureDependencies(
    DependencyConfigurationContext context,
    GetIt getIt,
  );
}

class DependencyConfigurationContext {
  DependencyConfigurationContext();
}

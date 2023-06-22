import 'package:deriv_model/di.dart';
import 'config.config.dart';
import 'package:injectable/injectable.dart';
import 'package:get_it/get_it.dart';

//global private function
@InjectableInit(initializerName: r'$initGetIt')
_configureMainDependencies(GetIt getIt) => getIt.$initGetIt();

class AppDependencyConfigurator implements DependencyConfigurator {
  @override
  Future configureDependencies(
      DependencyConfigurationContext context, GetIt getIt) {
    return Future.value(_configureMainDependencies(getIt));
  }
}

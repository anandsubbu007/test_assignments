import 'package:deriv_model/di.dart';
import 'package:injectable/injectable.dart';
import 'package:get_it/get_it.dart';
import 'di.config.dart';


//global private function
@InjectableInit(initializerName: r'$initNetworkGetIt')
_configureModuleDependencies(GetIt getIt) => getIt.$initNetworkGetIt();

class NetworkDependencyConfigurator implements DependencyConfigurator {
  @override
  Future configureDependencies(
      DependencyConfigurationContext context, GetIt getIt) {
    return Future.value(_configureModuleDependencies(getIt));
  }
}

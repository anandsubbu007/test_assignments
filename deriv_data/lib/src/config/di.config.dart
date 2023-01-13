// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:deriv_data/deriv_data.dart' as _i4;
import 'package:deriv_data/src/config/module.dart' as _i5;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:web_socket_channel/web_socket_channel.dart' as _i3;

/// ignore_for_file: unnecessary_lambdas
/// ignore_for_file: lines_longer_than_80_chars
extension GetItInjectableX on _i1.GetIt {
  /// initializes the registration of main-scope dependencies inside of [GetIt]
  _i1.GetIt $initNetworkGetIt({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final networkModule = _$NetworkModule();
    gh.lazySingleton<_i3.WebSocketChannel>(
        () => networkModule.channel(gh<String>(instanceName: 'socketUrl')));
    gh.lazySingleton<_i4.SocketPort>(
        () => networkModule.providerNetworkService(gh<_i3.WebSocketChannel>()));
    return this;
  }
}

class _$NetworkModule extends _i5.NetworkModule {}

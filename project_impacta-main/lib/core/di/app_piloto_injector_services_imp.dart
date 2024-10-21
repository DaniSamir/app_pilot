import 'package:app_piloto/core/di/app_piloto_injector_services.dart';
import 'package:get_it/get_it.dart';

class AppPilotoInjectorServicesImpl implements AppPilotoInjectorServices {
  final GetIt _getIt;
  AppPilotoInjectorServicesImpl(this._getIt);

  @override
  T getDependency<T extends Object>() {
    return _getIt.get<T>();
  }

  @override
  Future<void> registerDependency<T extends Object>(T dependency) async {
    if (!_getIt.isRegistered<T>()) {
      _getIt.registerSingleton<T>(dependency);
    }
  }

  @override
  Future<void> registerDependencyFactory<T extends Object>(
    T Function() factoryFunc,
  ) async {
    if (!_getIt.isRegistered<T>()) {
      _getIt.registerFactory<T>(factoryFunc);
    }
  }

  @override
  Future<void> registerDependencyLazySingleton<T extends Object>(
      T Function() factoryFunc) async {
    if (!_getIt.isRegistered<T>()) {
      _getIt.registerLazySingleton<T>(factoryFunc);
    }
  }
}

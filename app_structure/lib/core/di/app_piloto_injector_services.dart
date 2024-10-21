abstract class AppPilotoInjectorServices {
  T getDependency<T extends Object>();

  Future<void> registerDependency<T extends Object>(T dependency);

  Future<void> registerDependencyFactory<T extends Object>(
    T Function() factoryFunc,
  );

  Future<void> registerDependencyLazySingleton<T extends Object>(
    T Function() factoryFunc,
  );
}

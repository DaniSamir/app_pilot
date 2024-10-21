import 'package:app_piloto/core/di/app_piloto_injector_services.dart';
import 'package:app_piloto/core/di/app_piloto_injector_services_imp.dart';
import 'package:get_it/get_it.dart';

late final AppPilotoInjectorServices I;

///A variável "logger" é uma instância do serviço de registro de logs do AppPiloto.
//late final AppPilotoLoggerServices logger;

Future<void> initCore() async {
  I = AppPilotoInjectorServicesImpl(GetIt.instance);
  //logger = AppPilotoLoggerServicesImpl()..init();
}

import 'package:app_piloto/core/http/http_client_service.dart';
import 'package:app_piloto/core/init/init_core.dart';
import 'package:app_piloto/src/modules/create_contact/index.dart';

Future<void> registerMicroAppDependencies() async {
  // CreateContact
  I.registerDependencyLazySingleton<CreateContactDatasource>(
      () => CreateContactDatasourceImp());

  I.registerDependencyLazySingleton<CreateContactUsecase>(() =>
      CreateContactUsecaseImp(
          datasource: I.getDependency<CreateContactDatasource>()));

  I.registerDependency<CreateContactCubit>(CreateContactCubit(
      initialState: CreateContactInitialState(),
      usecase: I.getDependency<CreateContactUsecase>()));
}

import 'package:app_piloto/core/init/init_core.dart';
import 'package:app_piloto/src/modules/contact_list/index.dart';
import 'package:app_piloto/src/modules/create_contact/index.dart';

Future<void> registerMicroAppDependencies() async {
  // ContactList
  I.registerDependencyLazySingleton<ContactListDatasource>(
      () => ContactListDatasourceImp());

  I.registerDependencyLazySingleton<ContactListUsecase>(() =>
      ContactListUsecaseImp(
          datasource: I.getDependency<ContactListDatasource>()));

  I.registerDependency<ContactListCubit>(ContactListCubit(
    initialState: ContactListInitialState(),
    usecase: I.getDependency<ContactListUsecase>(),
  ));

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
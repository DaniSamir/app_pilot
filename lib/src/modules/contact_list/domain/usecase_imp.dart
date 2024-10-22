import 'package:app_piloto/core/models/contact_model.dart';
import 'package:app_piloto/src/modules/contact_list/index.dart';
import 'package:dartz/dartz.dart';

class ContactListUsecaseImp implements ContactListUsecase {
  final ContactListDatasource datasource;

  ContactListUsecaseImp({required this.datasource});

  @override
  Future<Either<ContactListFailure, List<ContactModel>?>> getContactList() async {
    try {
      final result = await datasource.getContactList();
      return result.fold((l) {
        return left(l);
      }, (r) {
        return right(r);
      });
    } catch (e) {
      return left(ContactListUnkownError(message: e.toString()));
    }
  }

    @override
  Future<Either<ContactListFailure,bool>> deleteContact(String nameUser) async {
    try {
      final result = await datasource.deleteContact(nameUser);
      return result.fold((l) {
        return left(l);
      }, (r) {
        return right(r);
      });
    } catch (e) {
      return left(ContactListUnkownError(message: e.toString()));
    }
  }
}

import 'package:app_piloto/core/models/contact_model.dart';
import 'package:app_piloto/src/modules/contact_list/index.dart';
import 'package:dartz/dartz.dart';

abstract class ContactListDatasource {
  Future<Either<ContactListFailure, List<ContactModel>?>> getContactList();
  Future<Either<ContactListFailure, bool>> deleteContact(String nameUser);
}

import 'package:app_piloto/core/models/contact_model.dart';
import 'package:app_piloto/src/modules/contact_list/index.dart';
import 'package:dartz/dartz.dart';

abstract class ContactListUsecase {
  Future<Either<ContactListFailure,List<ContactModel>?>> getContactList();
}

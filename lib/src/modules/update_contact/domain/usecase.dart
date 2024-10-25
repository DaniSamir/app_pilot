import 'package:app_piloto/core/models/contact_model.dart';
import 'package:app_piloto/src/modules/update_contact/index.dart';
import 'package:dartz/dartz.dart';

abstract class UpdateContactUsecase {
  Future<Either<UpdateContactFailure, bool>> updateContact(ContactModel contactModel);
}

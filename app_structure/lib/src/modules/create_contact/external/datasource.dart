import 'package:app_piloto/core/models/contact_model.dart';
import 'package:app_piloto/src/modules/create_contact/index.dart';
import 'package:dartz/dartz.dart';

abstract class CreateContactDatasource {
  Future<Either<CreateContactFailure, bool>> createUser(ContactModel contactModel);
}

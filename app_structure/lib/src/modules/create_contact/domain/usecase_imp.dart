import 'package:app_piloto/core/models/contact_model.dart';
import 'package:app_piloto/src/modules/create_contact/index.dart';
import 'package:dartz/dartz.dart';

class CreateContactUsecaseImp implements CreateContactUsecase {
  final CreateContactDatasource datasource;

  CreateContactUsecaseImp({required this.datasource});

  @override
  Future<Either<CreateContactFailure, bool>> createUser(
      ContactModel contactModel) async {
    try {
      final result = await datasource.createUser(contactModel);
      return result.fold((l) {
        return left(l);
      }, (r) {
        return right(r);
      });
    } catch (e) {
      return left(CreateContactUnkownError(message: e.toString()));
    }
  }
}

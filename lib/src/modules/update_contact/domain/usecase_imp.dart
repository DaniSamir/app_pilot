import 'package:app_piloto/core/models/contact_model.dart';
import 'package:app_piloto/src/modules/update_contact/index.dart';
import 'package:dartz/dartz.dart';

class UpdateContactUsecaseImp implements UpdateContactUsecase {
  final UpdateContactDatasource datasource;

  UpdateContactUsecaseImp({required this.datasource});

  @override
  Future<Either<UpdateContactFailure, bool>> updateContact(
      ContactModel contactModel) async {
    try {
      final result = await datasource.updateContact(contactModel);
      return result.fold((l) {
        return left(l);
      }, (r) {
        return right(r);
      });
    } catch (e) {
      return left(UpdateContactUnkownError(message: e.toString()));
    }
  }
}

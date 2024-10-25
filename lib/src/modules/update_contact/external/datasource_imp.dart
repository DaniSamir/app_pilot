import 'package:app_piloto/core/http/http.dart';
import 'package:app_piloto/core/models/contact_model.dart';
import 'package:app_piloto/src/modules/update_contact/index.dart';
import 'package:dartz/dartz.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

UpdateContactFailure getFailureError(AppPilotoResponse? response) {
  if (response == null) return UpdateContactUnkownError();
  switch (response.statusCode) {
    case 400:
      return UpdateContactRequestError(message: response.statusMessage, data: response.data);
    case 401:
      return UpdateContactUnauthorizedError(message: response.statusMessage, data: response.data);
    case 403:
      return UpdateContactForbiddenError(message: response.statusMessage, data: response.data);
    case 404:
      return UpdateContactRequestError(message: response.statusMessage, data: response.data);
    case 408:
      return UpdateContactRequestError(message: response.statusMessage, data: response.data);
    case 500:
      return UpdateContactInternalError(message: response.statusMessage, data: response.data);
    default:
      if (response.statusMessage.toUpperCase() == "OK") {
        response.statusMessage = "Ops, ocorreu um erro";
      }
      return UpdateContactUnkownError(message: response.statusMessage, code: response.statusCode.toString(), data: response.data);
  }
}

Future<bool> tryUpdateContact(ContactModel contactModel) async {
  try {
    DocumentReference documentReference = FirebaseFirestore.instance.collection('crud').doc(contactModel.userId);
    final modelMap = contactModel.toMap();
    await documentReference.update(modelMap);

    return true;
  } catch (e) {
    return false;
  }
}

class UpdateContactDatasourceImp implements UpdateContactDatasource {
  UpdateContactDatasourceImp();

  @override
  Future<Either<UpdateContactFailure, bool>> updateContact(ContactModel contactModel) async {
    try {
      bool response = await tryUpdateContact(contactModel);

      if (response != true) {
        // final UpdateContactFailure failure = getFailureError(response);
        return left(UpdateContactUnkownError());
      } else {
        return right(response);
      }
    } catch (e) {
      return left(UpdateContactUnkownError(message: e.toString()));
    }
  }
}

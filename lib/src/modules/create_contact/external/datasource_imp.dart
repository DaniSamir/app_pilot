import 'package:app_piloto/core/http/http.dart';
import 'package:app_piloto/core/models/contact_model.dart';
import 'package:app_piloto/src/modules/create_contact/index.dart';
import 'package:dartz/dartz.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

CreateContactFailure getFailureError(AppPilotoResponse? response) {
  if (response == null) return CreateContactUnkownError();
  switch (response.statusCode) {
    case 400:
      return CreateContactRequestError(message: response.statusMessage, data: response.data);
    case 401:
      return CreateContactUnauthorizedError(message: response.statusMessage, data: response.data);
    case 403:
      return CreateContactForbiddenError(message: response.statusMessage, data: response.data);
    case 404:
      return CreateContactRequestError(message: response.statusMessage, data: response.data);
    case 408:
      return CreateContactRequestError(message: response.statusMessage, data: response.data);
    case 500:
      return CreateContactInternalError(message: response.statusMessage, data: response.data);
    default:
      if (response.statusMessage.toUpperCase() == "OK") {
        response.statusMessage = "Ops, ocorreu um erro";
      }
      return CreateContactUnkownError(message: response.statusMessage, code: response.statusCode.toString(), data: response.data);
  }
}

Future<bool> tryCreateContact(ContactModel contactModel) async {
  try {
    DocumentReference documentReference = FirebaseFirestore.instance.collection('crud').doc(contactModel.nameUser);

    await documentReference.set(contactModel.toMap());

    return true;
  } catch (e) {
    return false;
  }
}

class CreateContactDatasourceImp implements CreateContactDatasource {
  CreateContactDatasourceImp();

  @override
  Future<Either<CreateContactFailure, bool>> createUser(ContactModel contactModel) async {
    try {
      bool response = await tryCreateContact(contactModel);

      if (response != true) {
        // final CreateContactFailure failure = getFailureError(response);
        return left(CreateContactUnkownError());
      } else {
        return right(response);
      }
    } catch (e) {
      return left(CreateContactUnkownError(message: e.toString()));
    }
  }
}

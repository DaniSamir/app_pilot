import 'package:app_piloto/core/http/http.dart';
import 'package:app_piloto/core/models/contact_model.dart';
import 'package:app_piloto/src/modules/contact_list/index.dart';
import 'package:dartz/dartz.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

ContactListFailure getFailureError(AppPilotoResponse? response) {
  if (response == null) return ContactListUnkownError();
  switch (response.statusCode) {
    case 400:
      return ContactListRequestError(
          message: response.statusMessage, data: response.data);
    case 401:
      return ContactListUnauthorizedError(
          message: response.statusMessage, data: response.data);
    case 403:
      return ContactListForbiddenError(
          message: response.statusMessage, data: response.data);
    case 404:
      return ContactListRequestError(
          message: response.statusMessage, data: response.data);
    case 408:
      return ContactListRequestError(
          message: response.statusMessage, data: response.data);
    case 500:
      return ContactListInternalError(
          message: response.statusMessage, data: response.data);
    default:
      if (response.statusMessage.toUpperCase() == "OK") {
        response.statusMessage = "Ops, ocorreu um erro";
      }
      return ContactListUnkownError(
          message: response.statusMessage,
          code: response.statusCode.toString(),
          data: response.data);
  }
}

class ContactListDatasourceImp implements ContactListDatasource {
  ContactListDatasourceImp();

  @override
  Future<Either<ContactListFailure, List<ContactModel>?>>
      getContactList() async {
    try {
      ContactModel? response;
      CollectionReference users = FirebaseFirestore.instance.collection('crud');

      users.get().then((QuerySnapshot snapshot) async {
        final ttt = snapshot.docs;

        final lllll = ttt;
      });

      if (response!.email == null) {
        // final ContactListFailure failure = getFailureError(response);
        return left(ContactListUnkownError());
      } else {
        return right(
            [ContactModel(email: '', nameUser: '', userId: '', phone: '')]);
      }
    } catch (e) {
      return left(ContactListUnkownError(message: e.toString()));
    }
  }
}

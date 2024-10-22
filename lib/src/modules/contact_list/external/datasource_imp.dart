import 'package:app_piloto/core/http/http.dart';
import 'package:app_piloto/core/models/contact_model.dart';
import 'package:app_piloto/src/modules/contact_list/index.dart';
import 'package:dartz/dartz.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

ContactListFailure getFailureError(AppPilotoResponse? response) {
  if (response == null) return ContactListUnkownError();
  switch (response.statusCode) {
    case 400:
      return ContactListRequestError(message: response.statusMessage, data: response.data);
    case 401:
      return ContactListUnauthorizedError(message: response.statusMessage, data: response.data);
    case 403:
      return ContactListForbiddenError(message: response.statusMessage, data: response.data);
    case 404:
      return ContactListRequestError(message: response.statusMessage, data: response.data);
    case 408:
      return ContactListRequestError(message: response.statusMessage, data: response.data);
    case 500:
      return ContactListInternalError(message: response.statusMessage, data: response.data);
    default:
      if (response.statusMessage.toUpperCase() == "OK") {
        response.statusMessage = "Ops, ocorreu um erro";
      }
      return ContactListUnkownError(message: response.statusMessage, code: response.statusCode.toString(), data: response.data);
  }
}

Future<bool> trydeleteContact(String nameUser) async {
  try {
    DocumentReference documentReference = FirebaseFirestore.instance.collection('crud').doc(nameUser);
    await documentReference.delete();

    return true;
  } catch (e) {
    return false;
  }
}

class ContactListDatasourceImp implements ContactListDatasource {
  ContactListDatasourceImp();

  @override
  Future<Either<ContactListFailure, List<ContactModel>?>> getContactList() async {
    try {
      CollectionReference users = FirebaseFirestore.instance.collection('crud');

      final contactListFirebase = await users.get().then((QuerySnapshot snapshot) {
        List<ContactModel> contacts = snapshot.docs.map((doc) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

          return ContactModel.fromMap(data);
        }).toList();

        return contacts;
      });

      if (contactListFirebase.isEmpty) {
        return left(ContactListUnkownError());
      } else {
        List<ContactModel> contactList = contactListFirebase;

        return right(contactList);
      }
    } catch (e) {
      return left(ContactListUnkownError(message: e.toString()));
    }
  }

  @override
  Future<Either<ContactListFailure, bool>> deleteContact(String nameUser) async {
    try {
      bool response = await trydeleteContact(nameUser);

      if (response != true) {
        return left(ContactListUnkownError());
      } else {
        return right(response);
      }
    } catch (e) {
      return left(ContactListUnkownError(message: e.toString()));
    }
  }
}

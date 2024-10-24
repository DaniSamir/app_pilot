import 'package:app_piloto/core/models/contact_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesCubit extends Cubit<List<ContactModel>> {
  FavoritesCubit() : super([]);
  List<ContactModel> contact = [];
  void insertFavorite(ContactModel contactModel) {
    if (!contact.contains(contactModel)) {
      contact = List.from(state)..add(contactModel);
      emit(contact);
    }
  }

  void removeFavorite(ContactModel contactModel) {
    if (contact.contains(contactModel)) {
      contact = List.from(state)..remove(contactModel);
      emit(contact);
    }
  }

  List<ContactModel> showFavorite() {
    return contact;
  }
}

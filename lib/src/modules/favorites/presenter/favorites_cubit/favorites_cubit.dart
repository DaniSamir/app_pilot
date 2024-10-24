import 'package:app_piloto/core/models/contact_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesCubit extends Cubit<List<ContactModel>> {
  FavoritesCubit() : super([]);

  void insertFavorite(ContactModel contactModel) {
    List<ContactModel> contact = List.from(state)..add(contactModel);
    emit(contact);
  }

  void removeFavorite(ContactModel contactModel) {
    List<ContactModel> contact = List.from(state)..removeWhere((item) => item.phone == contactModel.phone && item.email == contactModel.email);
    emit(contact);
  }

  List<ContactModel> readFavorite() {
    return state;
  }
}

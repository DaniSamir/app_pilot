import 'package:app_piloto/core/models/contact_model.dart';
import 'package:app_piloto/src/modules/contact_list/index.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactListCubit extends Cubit<ContactListState> {
  final ContactListUsecase usecase;
  List<ContactModel>? contactModelList;
  ContactListCubit({required ContactListState initialState, required this.usecase, this.contactModelList}) : super(initialState);

  void resetState() {
    emit(ContactListInitialState());
  }

  void cleanState() {
    emit(ContactListInitialState());
  }

  void emitSuccess() {
    emit(ContactListSuccessState(contactModelList: contactModelList));
  }

  Future<void> getContactList() async {
    try {
      emit(ContactListLoadingState());
      final result = await usecase.getContactList();
      result.fold((l) {
        emit(ContactListErrorState(l));
        return;
      }, (r) {
        contactModelList = r;
        emitSuccess();
        return;
      });
    } catch (e) {
      emit(ContactListErrorState(ContactListUnkownError(message: e.toString())));
    }
  }

  Future<void> deleteContact() async {
    try {
      emit(ContactListLoadingState());
      final result = await usecase.getContactList();
      result.fold((l) {
        emit(ContactListErrorState(l));
        return;
      }, (r) {
       emit(DeleteContactSuccessState());
        return;
      });
    } catch (e) {
      emit(ContactListErrorState(ContactListUnkownError(message: e.toString())));
    }
  }
}

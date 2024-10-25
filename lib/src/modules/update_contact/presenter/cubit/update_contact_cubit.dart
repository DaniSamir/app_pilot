import 'package:app_piloto/core/models/contact_model.dart';
import 'package:app_piloto/src/modules/update_contact/index.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateContactCubit extends Cubit<UpdateContactState> {
  final UpdateContactUsecase usecase;

  UpdateContactCubit({required UpdateContactState initialState, required this.usecase}) : super(initialState);

  void resetState() {
    emit(UpdateContactInitialState());
  }

  void cleanState() {
    emit(UpdateContactInitialState());
  }

  Future<void> updateContact(ContactModel contactModel) async {
    try {
      emit(UpdateContactLoadingState());
      final result = await usecase.updateContact(contactModel);
      result.fold((l) {
        emit(UpdateContactErrorState(l));
        return;
      }, (r) {
        emit(UpdateContactSuccessState());
        return;
      });
    } catch (e) {
      emit(UpdateContactErrorState(UpdateContactUnkownError(message: e.toString())));
    }
  }
}

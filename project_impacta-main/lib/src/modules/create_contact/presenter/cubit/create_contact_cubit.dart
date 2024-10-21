import 'package:app_piloto/core/models/contact_model.dart';
import 'package:app_piloto/src/modules/create_contact/index.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateContactCubit extends Cubit<CreateContactState> {
  final CreateContactUsecase usecase;

  CreateContactCubit(
      {required CreateContactState initialState, required this.usecase})
      : super(initialState);

  void resetState() {
    emit(CreateContactInitialState());
  }

  void cleanState() {
    emit(CreateContactInitialState());
  }

  Future<void> createUser(ContactModel document) async {
    emit(CreateContactLoadingState());
    final result = await usecase.createUser(document);
    result.fold((l) {
      emit(CreateContactErrorState(l));
      return;
    }, (r) {
      emit(CreateContactSuccessState());
      return;
    });
  }
}

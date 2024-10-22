import 'package:app_piloto/src/modules/create_contact/index.dart';
import 'package:equatable/equatable.dart';

abstract class CreateContactState extends Equatable {}

class CreateContactInitialState extends CreateContactState {
  @override
  List<Object> get props => [];
}

class CreateContactLoadingState extends CreateContactState {
  CreateContactLoadingState();
  @override
  List<Object> get props => [];
}

class CreateContactSuccessState extends CreateContactState {
  CreateContactSuccessState();

  @override
  List<Object> get props => [];
}

class CreateContactErrorState extends CreateContactState {
  final CreateContactFailure failure;
  CreateContactErrorState(this.failure);

  @override
  List<Object> get props => [failure];
}

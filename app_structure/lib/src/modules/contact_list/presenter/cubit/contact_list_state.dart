import 'package:app_piloto/core/models/contact_model.dart';
import 'package:app_piloto/src/modules/contact_list/index.dart';
import 'package:equatable/equatable.dart';

abstract class ContactListState extends Equatable {}

class ContactListInitialState extends ContactListState {
  @override
  List<Object> get props => [];
}

class ContactListLoadingState extends ContactListState {
  ContactListLoadingState();
  @override
  List<Object> get props => [];
}

class ContactListSuccessState extends ContactListState {
  final List<ContactModel>? contactModelList;
  ContactListSuccessState({required this.contactModelList});

  @override
  List<Object> get props => [];
}

class ContactListErrorState extends ContactListState {
  final ContactListFailure failure;
  ContactListErrorState(this.failure);

  @override
  List<Object> get props => [failure];
}

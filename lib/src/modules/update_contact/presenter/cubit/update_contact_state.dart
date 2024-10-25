import 'package:app_piloto/src/modules/update_contact/index.dart';
import 'package:equatable/equatable.dart';

abstract class UpdateContactState extends Equatable {}

class UpdateContactInitialState extends UpdateContactState {
  @override
  List<Object> get props => [];
}

class UpdateContactLoadingState extends UpdateContactState {
  UpdateContactLoadingState();
  @override
  List<Object> get props => [];
}

class UpdateContactSuccessState extends UpdateContactState {
  UpdateContactSuccessState();

  @override
  List<Object> get props => [];
}

class UpdateContactIsFavoriteState extends UpdateContactState {
  UpdateContactIsFavoriteState();

  @override
  List<Object> get props => [];
}

class UpdateContactIsNoFavoriteState extends UpdateContactState {
  UpdateContactIsNoFavoriteState();

  @override
  List<Object> get props => [];
}

class UpdateContactErrorState extends UpdateContactState {
  final UpdateContactFailure failure;
  UpdateContactErrorState(this.failure);

  @override
  List<Object> get props => [failure];
}

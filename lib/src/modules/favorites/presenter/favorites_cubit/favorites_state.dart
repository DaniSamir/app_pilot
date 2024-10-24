import 'package:app_piloto/core/models/contact_model.dart';
import 'package:app_piloto/src/modules/favorites/index.dart';
import 'package:equatable/equatable.dart';

abstract class FavoritesState extends Equatable {}

class FavoritesInitialState extends FavoritesState {
  @override
  List<Object> get props => [];
}

class FavoritesLoadingState extends FavoritesState {
  FavoritesLoadingState();
  @override
  List<Object> get props => [];
}

class FavoritesSuccessState extends FavoritesState {
  final List<ContactModel>? contactModelList;
  FavoritesSuccessState({required this.contactModelList});

  @override
  List<Object> get props => [];
}



class FavoritesErrorState extends FavoritesState {
  final FavoritesFailure failure;
  FavoritesErrorState(this.failure);

  @override
  List<Object> get props => [failure];
}

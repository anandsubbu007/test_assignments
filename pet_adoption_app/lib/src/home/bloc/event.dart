// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:pet_adoption_app/model/pet_model.dart';

class HomeEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class HomeState extends Equatable {
  @override
  List<Object?> get props => [];
}

/// On Loading
class LoadingState extends HomeState {}

/// after loaded
class DataLoadedState extends HomeState {
  String id;

  /// Pet datas
  List<PetModel> datas;
  DataLoadedState({
    this.id = "",
    required this.datas,
  });
  @override
  List<Object?> get props => [id, datas];
}

class NoDataState extends HomeState {
  List<PetModel> datas = [];
}

/// onSearch Text
class HomeSearchEvent extends HomeEvent {
  String searchTxt;
  HomeSearchEvent({
    this.searchTxt = "",
  });
  @override
  List<Object?> get props => [searchTxt];
}

/// to load more
class LoadMoreEvemt extends HomeEvent {}

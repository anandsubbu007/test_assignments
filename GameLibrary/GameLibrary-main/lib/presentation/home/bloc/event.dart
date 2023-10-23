// ignore_for_file: must_be_immutable
import 'package:flutter_ap/model/game_model.dart';
import 'package:equatable/equatable.dart';

class HomeEvent {}

class HomeState extends Equatable {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

/// On Loading
class LoadingState extends HomeState {}

/// after loaded
class DataLoadedState extends HomeState {
  String id;

  /// Game datas
  List<GamesModel> datas;
  DataLoadedState({
    this.id = "",
    required this.datas,
  });
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class NoDataState extends HomeState {
  List<GamesModel> datas = [];
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class ErrorState extends HomeState {
  String? error;
  ErrorState(this.error);
  @override
  List<Object?> get props => [identityHashCode(this)];
}

/// onSearch Text
class HomeSearchEvent extends HomeEvent {
  String searchTxt;
  List<int> geners;
  List<int> platform;
  HomeSearchEvent(
      {this.searchTxt = "", this.geners = const [], this.platform = const []});
}

/// to load more
class LoadMoreEvent extends HomeEvent {}

// ignore_for_file: must_be_immutable

import 'package:flutter_ap/model/game_model.dart';

class DetailEvent {}

class DetailState {}

/// to Load dats
class LoadData extends DetailEvent {}

/// on Loading
class LoadingState extends DetailState {}

/// on loaded
class Loaded extends DetailState {
  GamesModel data;
  Loaded({required this.data});
}

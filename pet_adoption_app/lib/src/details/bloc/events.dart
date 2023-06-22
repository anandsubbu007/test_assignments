// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:pet_adoption_app/model/pet_model.dart';

class DetailEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class DetailState extends Equatable {
  @override
  List<Object?> get props => [];
}

/// to Load dats
class LoadData extends DetailEvent {
  @override
  List<Object?> get props => [""];
}

/// on Loading
class LoadingState extends DetailState {}

/// on loaded
class Loaded extends DetailState {
  PetModel data;
  Loaded({required this.data});
  @override
  List<Object?> get props => [data];
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_ap/infrastructure/repo/game_repo.dart';
import 'package:flutter_ap/model/game_model.dart';
import 'package:flutter_ap/presentation/details/bloc/events.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

export 'package:flutter_ap/presentation/details/bloc/events.dart';

/// detaisl of game Blco
class DetailsBloc extends Bloc<DetailEvent, DetailState> {
  /// Adoption data
  bool isAdopted = true;

  late GameRepo repo;
  final int id;
  DetailsBloc({required this.id, GameRepo? repo}) : super(LoadingState()) {
    this.repo = repo ?? GameRepo();
    on<DetailEvent>(onEventMapping);
    add(LoadData());
  }

  /// loaded Game data
  late GamesModel _game;

  /// Listening to event
  void onEventMapping(DetailEvent event, Emitter<DetailState> emit) async {
    if (event is LoadData) {
      _game = await repo.getById(id);
      emit(Loaded(data: _game));
    }
  }

  /// on Tap Adopted
  void onClickAdoptMe(BuildContext context) async {
    isAdopted = !isAdopted;
  }
}

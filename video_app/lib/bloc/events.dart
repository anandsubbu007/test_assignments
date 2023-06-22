import 'package:video_app/domain/model.dart';
import 'package:video_player/video_player.dart';

class HomeEvent {}

class HomeState {}

class LoadingState extends HomeState {}

// To Load Data for [Model]
class LoadData extends HomeEvent {
  final Model data;
  LoadData({required this.data});
}

/// To Load [VideoController] for videoplayer
class LoadedData extends HomeState {
  final VideoPlayerController controller;

  LoadedData(this.controller);
}

/// Dialog to show State
class ShowDialogState extends HomeState {
  final String title;
  final String details;
  final List<Model> models;
  ShowDialogState(
    this.title,
    this.details,
    this.models,
  );
}

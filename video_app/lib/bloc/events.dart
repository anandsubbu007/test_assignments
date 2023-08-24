import 'package:video_player/video_player.dart';

class HomeEvent {}

class HomeState {}

class LoadingState extends HomeState {}

// To Load Data for [Model]
class LoadVideo extends HomeEvent {}

// To Load Data for [Model]
class ResumeVideo extends HomeEvent {}

/// To Load [VideoController] for videoplayer
class LoadedData extends HomeState {
  final VideoPlayerController controller;

  LoadedData(this.controller);
}

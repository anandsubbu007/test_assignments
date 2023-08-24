import 'dart:async';

import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_app/bloc/events.dart';
import 'package:video_app/data/repo.dart';
import 'package:flutter_meedu_videoplayer/meedu_player.dart';

// BLOC for Home Page
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  static const String hlsUrl =
      'https://demo.unified-streaming.com/k8s/features/stable/video/tears-of-steel/tears-of-steel.ism/.m3u8';
  MeeduPlayerController controller =
      MeeduPlayerController(controlsStyle: ControlsStyle.primary);
  late Repo repo;

  /// Stream controller for Video Player
  StreamController<MeeduPlayerController> videoStream =
      StreamController.broadcast();

  /// Video Controller
  MeeduPlayerController? get initialVideo => controller;

  HomeBloc() : super(LoadingState()) {
    repo = Repo();
    initListner();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      /// Load Initial Data
      if (controller == null) loadInitialData();
    });
  }

  /// Intalizing Listner
  void initListner() {
    on<HomeEvent>((event, emit) {
      if (event is LoadVideo) {
        controller.dispose();
        controller.setDataSource(
          DataSource(type: DataSourceType.network, source: hlsUrl),
          autoplay: true,
        );
        videoStream.add(controller);
      }
      // controller.addListener(() {
      //   if (controller!.value.duration.inMilliseconds > 0) {
      //     currentPosition = controller!.value.duration.inMilliseconds;
      //   }
      // });
    });
  }

  int currentPosition = 0;

  ///
  void loadInitialData() async {
    add(LoadVideo());
  }

  /// reseting data
  void reset() {
    currentPosition = 0;
    add(LoadVideo());
  }

  void dispose() {
    controller.dispose();
  }
}

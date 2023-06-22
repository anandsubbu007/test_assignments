import 'dart:async';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_app/bloc/events.dart';
import 'package:video_player/video_player.dart';

import 'package:video_app/data/repo.dart';
import 'package:video_app/domain/model.dart';

// BLOC for Home Page
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  VideoPlayerController? controller;
  late Repo repo;

  /// Stream controller for Video Player
  StreamController<VideoPlayerController> videoStream =
      StreamController.broadcast();

  /// Stream controller for DIalog Component
  StreamController<ShowDialogState?> dialogState = StreamController.broadcast();

  /// Video Controller
  VideoPlayerController? get initialVideo => controller;

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
      if (event is LoadData) {
        controller?.dispose();
        availableChildrens = event.data.childrens;
        controller =
            VideoPlayerController.asset('assets/${event.data.assetPath}');
        dialogState.add(null);
        videoStream.add(controller!);
      }
      controller?.addListener(() {
        if (controller!.value.duration.inMilliseconds > 0) {
          final max = controller!.value.position.inMilliseconds;
          final current = controller!.value.duration.inMilliseconds;
          final diff = current - max;
          if (controller!.value.duration.inSeconds > 2 && diff > 1) {
            //
            // controller!.pause();
            // dialogState.add(ShowDialogState(
            //   "Video is long than 2 sec",
            //   "Do you want to continue?",
            //   availableChildrens,
            // ));
          }
          if (diff < 400) {
            /// If video going to reach end. then showing dialog for next available videos
            controller!.pause();
            dialogState.add(ShowDialogState(
              "Select Any Options from Below To Play Next Video",
              "",
              availableChildrens,
            ));
          }
        }
      });
    });
  }

  /// current loading model
  Model? initialData;

  /// Next Available Models
  List<Model> availableChildrens = [];

  ///
  void loadInitialData() async {
    initialData = await repo.getHomePgModels();
    add(LoadData(data: initialData!));
  }

  /// reseting data
  void reset() {
    if (initialData != null) add(LoadData(data: initialData!));
  }

  void dispose() {
    controller?.dispose();
  }
}

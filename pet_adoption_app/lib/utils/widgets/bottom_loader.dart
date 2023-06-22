import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:visibility_detector/visibility_detector.dart';

enum LoaderState { none, loading, noMoreData }

/// Bottom Loader to show loading & notify to fetch data
class BottomLoader extends StatefulWidget {
  final Future<LoaderState> Function() onVisible;
  const BottomLoader({
    super.key,
    required this.onVisible,
  });

  @override
  State<BottomLoader> createState() => _BottomLoaderState();
}

class _BottomLoaderState extends State<BottomLoader> {
  late final StreamController<LoaderState> _stateController =
      StreamController<LoaderState>.broadcast();

  LoaderState lastState = LoaderState.loading;
  void updateState(LoaderState state) {
    if (lastState != state) {
      lastState = state;
      _stateController.add(lastState);
    }
  }

  Future<void> callback() async {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      final newState = await widget.onVisible();
      updateState(newState);
    });
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: const Key('BottomLoader'),
      onVisibilityChanged: (visibilityInfo) {
        final visiblePercentage = visibilityInfo.visibleFraction * 100;
        if (lastState == LoaderState.noMoreData) return;
        if (visiblePercentage > 30) {
          updateState(LoaderState.loading);
          callback();
        } else if (visiblePercentage < 2) {
          updateState(LoaderState.none);
        }
      },
      child: StreamBuilder<LoaderState>(
          initialData: lastState,
          stream: _stateController.stream,
          builder: (context, snapshot) {
            final state = snapshot.data ?? lastState;
            if (state == LoaderState.noMoreData) {
              return const Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 18),
                    child: Center(
                        child: Text(
                      '-- No More Data --',
                      textAlign: TextAlign.center,
                    )),
                  ),
                ],
              );
            } else if (state == LoaderState.loading) {
              Future.delayed(const Duration(seconds: 1), callback);
              return Container(
                height: 40,
                margin: const EdgeInsets.all(8),
                alignment: Alignment.center,
                child: const CircularProgressIndicator(color: Colors.white),
              );
            } else {
              return const SizedBox();
            }
          }),
    );
  }
}

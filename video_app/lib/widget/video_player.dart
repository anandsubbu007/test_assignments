import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_meedu_videoplayer/meedu_player.dart';

/// Video Player handler
class AppVideoPlayer extends StatefulWidget {
  /// VideoPlayerController
  final MeeduPlayerController controller;
  const AppVideoPlayer({super.key, required this.controller});

  @override
  State<AppVideoPlayer> createState() => _AppVideoPlayerState();
}

class _AppVideoPlayerState extends State<AppVideoPlayer> {
  @override
  Widget build(BuildContext context) {
    // if (widget.controller.value.errorDescription != null) {
    //   if (kDebugMode) {
    //     print(widget.controller.value.errorDescription);
    //   }
    // }
    // widget.controller.addListener(() => setState(() {}));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // VideoProgressIndicator(widget.controller, allowScrubbing: true),
        Expanded(
          child: Container(
            alignment: Alignment.topCenter,
            child: Stack(
              children: [
                AspectRatio(
                    aspectRatio: 16 / 9,
                    child: MeeduVideoPlayer(controller: widget.controller)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

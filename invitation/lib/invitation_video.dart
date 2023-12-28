import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:video_player/video_player.dart';

class InvitationVideo extends StatelessWidget {
  const InvitationVideo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color(0xFFB5163E),

      // #
      body: _AssetVideo(),
    );
  }
}

class _AssetVideo extends StatefulWidget {
  @override
  _AssetVideoState createState() => _AssetVideoState();
}

class _AssetVideoState extends State<_AssetVideo> {
  late VideoPlayerController _controller;
  bool isVideoEnded = false;
  @override
  void initState() {
    isVideoEnded = false;
    super.initState();
    _controller =
        VideoPlayerController.asset('assets/video/Red_Wedding_Invitation.mp4');

    _controller.addListener(() {
      isVideoEnded =
          (_controller.value.duration - _controller.value.position).inSeconds ==
                  1 &&
              _controller.value.duration.inMicroseconds > 0;
      if (isVideoEnded) _controller.pause();
      debugPrint(_controller.value.toString());
      setState(() {});
    });
    // _controller.setLooping(true);
    _controller.initialize().then((_) => setState(() {}));
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _controller.play();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void toMap() {
    const marathiPadapuVedu =
        "https://maps.app.goo.gl/b1oirtsRxSFzf1EA7?g_st=ic";
    launchUrlString(marathiPadapuVedu);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      body: Stack(
        children: [
          LayoutBuilder(
            builder: (context, constraints) => _controller.value.isInitialized
                ? AspectRatio(
                    aspectRatio: constraints.maxWidth / constraints.maxHeight,
                    // _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  )
                : Center(
                    child: Image.asset(
                      "assets/images/preloader.gif",
                    ),
                  ),
          ),
          // if (isVideoEnded)
        ],
      ),
      floatingActionButton: Row(
        children: [
          const SizedBox(width: 35),
          const Spacer(),
          FloatingActionButton(
            backgroundColor: const Color(0xFFFCC403),
            focusColor: const Color(0xFFB5163E),
            onPressed: toMap,
            child: const Icon(Icons.drive_eta_sharp, color: Color(0xFFB5163E)),
          ),
        ],
      ),
      // bottomNavigationBar: Container(
      //   padding: EdgeInsets.all(5),
      //   color: const Color(0xFFFCC403),
      //   child: Row(children: [
      //     ElevatedButton(onPressed: () {}, child: Text("Location"))
      //   ]),
      // ),
    );
  }
}

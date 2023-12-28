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
    reset();
    super.initState();
    _controller =
        VideoPlayerController.asset('assets/video/Red_Wedding_Invitation.mp4');
    listener();
    videoInit();
    Future.delayed(const Duration(seconds: 20), () {
      switchImage();
    });
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      play();
    });
  }

  void videoInit() {
    _controller.initialize().then((_) {
      setState(() {});
    }, onError: (e) {
      debugPrint(e.toString());
      switchImage();
    });
  }

  void listener() {
    _controller.addListener(() {
      isVideoEnded =
          (_controller.value.duration - _controller.value.position).inSeconds ==
                  1 &&
              _controller.value.duration.inMicroseconds > 0;
      if (isVideoEnded) {
        _controller.pause();
      }
      debugPrint(_controller.toString());

      setState(() {});
    });
  }

  void reset() {
    isVideoEnded = false;
    i = 0;
    showImageIntead = false;
  }

  int i = 0;
  void play() async {
    await Future.delayed(const Duration(milliseconds: 500), () async {
      await _controller.setVolume(0);
      _controller.play().onError((error, stackTrace) => onError(error));
    });
  }

  void onError(e) {
    debugPrint(e.toString());
    if (i < 30) {
      i += 1;
      Future.delayed(const Duration(milliseconds: 500), () {
        play();
      });
    } else {
      switchImage();
    }
  }

  void switchImage() {
    showImageIntead = true;
    setState(() {});
  }

  bool showImageIntead = false;
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
      body: LayoutBuilder(
        builder: (context, constraints) => showImageIntead
            ? Center(
                child: Image.asset(
                  "assets/images/weeding_card.png",
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.center,
                ),
              )
            : _controller.value.isInitialized
                ? AspectRatio(
                    aspectRatio: constraints.maxWidth / constraints.maxHeight,
                    // _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  )
                : Builder(builder: (context) {
                    return Center(
                      child: Image.asset(
                        "assets/images/preloader.gif",
                      ),
                    );
                  }),
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

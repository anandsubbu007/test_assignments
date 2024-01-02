// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:invitation/html_widget.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:video_player/video_player.dart';
import 'package:pulsator/pulsator.dart';

class InvitationVideo extends StatelessWidget {
  const InvitationVideo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    // reset();
    super.initState();
    // _controller =
    //     VideoPlayerController.asset('assets/video/Red_Wedding_Invitation.mp4');
    // listener();
    // videoInit();
    // Future.delayed(const Duration(seconds: 16), () {
    //   switchImage();
    // });
    // SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
    //   play();
    // });
  }

  // void videoInit() {
  //   _controller.initialize().then((_) {
  //     setState(() {});
  //   }, onError: (e) {
  //     debugPrint(e.toString());
  //     switchImage();
  //   });
  // }

  // void listener() {
  //   _controller.addListener(() {
  //     isVideoEnded =
  //         (_controller.value.duration - _controller.value.position).inSeconds ==
  //                 1 &&
  //             _controller.value.duration.inMicroseconds > 0;
  //     if (isVideoEnded) {
  //       _controller.pause();
  //     }
  //     // debugPrint(_controller.toString());

  //     setState(() {});
  //   });
  // }

  // void reset() {
  //   isVideoEnded = false;
  //   i = 0;
  //   showImageIntead = false;
  // }

  // int i = 0;
  // void play() async {
  //   await Future.delayed(const Duration(milliseconds: 500), () async {
  //     await _controller.setVolume(0);
  //     _controller.play().onError((error, stackTrace) => onError(error));
  //   });
  // }

  // void onError(e) {
  //   debugPrint(e.toString());
  //   if (i < 30) {
  //     i += 1;
  //     Future.delayed(const Duration(milliseconds: 500), () {
  //       play();
  //     });
  //   } else {
  //     switchImage();
  //   }
  // }

  // void switchImage() {
  //   showImageIntead = true;
  //   setState(() {});
  // }

  // bool showImageIntead = false;
  @override
  void dispose() {
    // _controller.dispose();
    super.dispose();
  }

  void toMap() {
    const marathiPadapuVedu =
        "https://maps.app.goo.gl/b1oirtsRxSFzf1EA7?g_st=ic";
    launchUrlString(marathiPadapuVedu);
  }

  Widget button() {
    return SizedBox(
      height: 80,
      width: 80,
      child: InkWell(
        onTap: toMap,
        child: Pulsator(
          fit: PulseFit.contain,
          autoStart: true,
          startFromScratch: false,
          style: const PulseStyle(color: Color(0xFFFCC403)),
          count: 3,
          duration: const Duration(seconds: 3),
          repeat: 0,
          child: Container(
              padding: const EdgeInsets.all(9),
              decoration: BoxDecoration(
                  color: const Color(0xFFFCC403),
                  borderRadius: BorderRadius.circular(200)),
              child:
                  const Icon(Icons.drive_eta_sharp, color: Color(0xFFB5163E))),
        ),
      ),
    );
  }

  int tapCount = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      // _controller.value.isInitialized ? Colors.black54 : Colors.white,
      body: Center(
        child: Stack(
          children: [
            // Center(child: GifRenderer()),
            Image.asset(
              "assets/images/Red_Wedding_Invitation.gif",
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                print(error);
                print(stackTrace);
                return Image.asset(
                  "assets/images/weeding_card.png",
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.center,
                );
              },
              semanticLabel: "Anand_wedding_invitaiton",
            ),
            Positioned.fill(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Spacer(flex: 6),
                  Expanded(
                    flex: 1,
                    child: InkWell(
                        onTap: toMap, child: const SizedBox(height: 60)),
                  ),
                  const Spacer(flex: 2)
                ],
              ),
            ),
            Positioned(bottom: 5, right: 5, child: button())
          ],
        ),
      ),
      // floatingActionButton: Row(
      //   children: [
      //     const SizedBox(width: 35),
      //     const Spacer(),
      // FloatingActionButton(
      //   backgroundColor: const Color(0xFFFCC403),
      //   focusColor: const Color(0xFFB5163E),
      //   onPressed: toMap,
      //   child: const Icon(Icons.drive_eta_sharp, color: Color(0xFFB5163E)),
      // ),
      //   ],
      // ),
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
         // return showImageIntead
                //     ? Center(
                //         child: Stack(
                //           children: [
                //             Image.asset(
                //               "assets/images/weeding_card.png",
                //               fit: BoxFit.scaleDown,
                //               alignment: Alignment.center,
                //             ),
                //             Positioned.fill(
                //               child: Column(
                //                 crossAxisAlignment: CrossAxisAlignment.stretch,
                //                 mainAxisAlignment: MainAxisAlignment.end,
                //                 children: [
                //                   const Spacer(flex: 6),
                //                   Expanded(
                //                     flex: 1,
                //                     child: InkWell(
                //                         onTap: toMap,
                //                         child: const SizedBox(height: 60)),
                //                   ),
                //                   const Spacer(flex: 2)
                //                 ],
                //               ),
                //             ),
                //           ],
                //         ),
                //       )
                //     : _controller.value.isInitialized
                //         ? AspectRatio(
                //             aspectRatio: constraints.maxWidth / constraints.maxHeight,
                //             // _controller.value.aspectRatio,
                //             child: VideoPlayer(_controller),
                //           )
                //         : InkWell(
                //             child: Center(
                //               child: Image.asset(
                //                 "assets/images/pre_loader.gif",
                //               ),
                //             ),
                //             onTap: () {
                //               tapCount += 1;
                //               if (tapCount > 2) {
                //                 switchImage();
                //               }
                //             },
                //           );
         
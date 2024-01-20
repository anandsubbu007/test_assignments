// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:intro/intro.dart';
import 'package:pulsator/pulsator.dart';

final _introController = IntroController(stepCount: 1);

class InvitationVideo extends StatelessWidget {
  const InvitationVideo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      body: Intro(
        controller: _introController,
        cardDecoration: IntroCardDecoration(
          align: IntroCardAlign.outsideLeftTop,
          tapBarrierToContinue: true,
          closeButtonLabel: "Close",
          closeButtonStyle: ButtonStyle(
            backgroundColor:
                MaterialStateColor.resolveWith((states) => Colors.black),
            shape: MaterialStateProperty.resolveWith((states) =>
                const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5)))),
          ),
          padding: const EdgeInsets.all(10),
          backgroundColor: Colors.black12,
        ),
        child: _AssetVideo(),
      ),
    );
  }
}

class _AssetVideo extends StatefulWidget {
  @override
  _AssetVideoState createState() => _AssetVideoState();
}

class _AssetVideoState extends State<_AssetVideo> {
  bool isVideoEnded = false;
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (!isTapped) {
        _introController.start(context);
        Future.delayed(const Duration(seconds: 3), () {
          _introController.close();
        });
      }
    });
  }

  bool isTapped = false;

  void toMap() {
    isTapped = true;
    const LocationBottomSheet().show(context);
  }

  Widget button() {
    return SizedBox(
      height: 80,
      width: 80,
      child: InkWell(
        onTap: toMap,
        child: Pulsator(
          fit: PulseFit.cover,
          autoStart: true,
          startFromScratch: false,
          style: const PulseStyle(color: Colors.white),
          count: 3,
          duration: const Duration(seconds: 3),
          repeat: 0,
          child: Center(
            child: Container(
              height: 60,
              width: 60,
              alignment: Alignment.center,
              margin: const EdgeInsets.fromLTRB(8, 8, 8, 8),
              padding: const EdgeInsets.fromLTRB(4, 0, 0, 0),
              decoration: BoxDecoration(
                  color: Colors.white60,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: const [
                    BoxShadow(
                        offset: Offset(0, 0),
                        color: Colors.black54,
                        blurRadius: 4,
                        spreadRadius: 2)
                  ]),
              child: Image.asset("assets/images/google_location.png"),
            ),
          ),
        ),
      ),
    );
  }

  int tapCount = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Stack(
          children: [
            const Positioned.fill(child: SizedBox()),
            Align(
              alignment: Alignment.center,
              child: FutureBuilder(
                  future: Future.delayed(const Duration(seconds: 2)),
                  builder: (context, snapshot) {
                    return Image.asset(
                      "assets/images/weeding_card.png",
                      fit: BoxFit.contain,
                      semanticLabel: "Anand_wedding_invitaiton_Card",
                    );
                  }),
            ),
            // Align(
            //   alignment: Alignment.center,
            //   child: Container(
            //     constraints: const BoxConstraints(maxWidth: 380),
            //     child: Card(
            //       color: Colors.white,
            //       margin: const EdgeInsets.all(25),
            //       child: Padding(
            //         padding: const EdgeInsets.all(8.0),
            //         child: Image.asset("assets/images/happy.gif"),
            //       ),
            //     ),
            //   ),
            // ),
            Align(
              alignment: Alignment.center,
              child: Image.asset(
                "assets/images/red_wedding_invitation.gif",
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
            Positioned(
                top: 7,
                right: 6,
                child: IntroStepTarget(
                  step: 1,
                  controller: Intro.of(context).controller,
                  cardContents: const TextSpan(
                      text: "Navigato To Location",
                      style: TextStyle(fontWeight: FontWeight.w500)),
                  child: button(),
                ))
          ],
        ),
      ),
    );
  }
}

class LocationBottomSheet extends StatelessWidget {
  const LocationBottomSheet({super.key});
  void show(BuildContext context) {
    showModalBottomSheet(context: context, builder: (ctx) => this);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: const BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15), topRight: Radius.circular(15))),
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
          width: double.infinity,
          child: const Text(
            "Events Location",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
          child: IntrinsicWidth(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Weeding Location\n(11/02/2024 - 9.00am-12.00am)",
                    textAlign: TextAlign.center,
                  ),
                  ElevatedButton(
                    onPressed: Actions.toKaraikudi,
                    child: Text("Marathi Padaippu Veedu"),
                  ),
                  // SizedBox(height: 5),
                  // Center(
                  //   child: ElevatedButton(
                  //     onPressed: Actions.toKaraikudi,
                  //     child: Text("Car Parking"),
                  //   ),
                  // ),
                  SizedBox(height: 10),
                  Text(
                    "Ponnamaravathi Location\n(10/02/2024)",
                    textAlign: TextAlign.center,
                  ),
                  ElevatedButton(
                    onPressed: Actions.toPonnamaravathi,
                    child: Text("Veera Perumal Thirumana Mandapam"),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Reception\n(18/02/2024 - Evening)",
                    textAlign: TextAlign.center,
                  ),
                  ElevatedButton(
                    onPressed: Actions.toReception,
                    child: Text("City Hall Residency, Mannai"),
                  ),
                  SizedBox(height: 15),
                ]),
          ),
        ),
      ],
    );
  }
}

class Actions {
  static void toKaraikudi() {
    const marathiPadapuVedu =
        "https://maps.app.goo.gl/b1oirtsRxSFzf1EA7?g_st=ic";
    launchUrlString(marathiPadapuVedu);
  }

  static void toKaraikudiCarParking() {
    const marathiPadapuVedu =
        "https://maps.app.goo.gl/b1oirtsRxSFzf1EA7?g_st=ic";
    launchUrlString(marathiPadapuVedu);
  }

  static void toPonnamaravathi() {
    const location = "https://maps.app.goo.gl/wLKtJBsHx1n5Rzhz5";
    launchUrlString(location);
  }

  static void toReception() {
    const location = "https://maps.app.goo.gl/hX5mswyhxkwHXqAX6";
    launchUrlString(location);
  }
}

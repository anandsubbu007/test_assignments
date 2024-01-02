// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:ui_web';

import 'package:flutter/material.dart';
import 'dart:html';

class GifRenderer extends StatelessWidget {
  const GifRenderer({super.key});

  @override
  Widget build(BuildContext context) {
    // build the HTML Img element.
    platformViewRegistry.registerViewFactory(
      "Gif Renderer",
      (int viewId) {
        ImageElement element = ImageElement()
          ..src = "assets/images/Red_Wedding_Invitation.gif"
          ..style.border = "none"
          ..style.boxAlign = 'center'
          ..style.alignContent = "center"
          ..style.alignSelf = "center";
        return element;
      },
    );

    return Container(
        constraints: const BoxConstraints(maxWidth: 430),
        child: const HtmlElementView(viewType: "Gif Renderer"));
  }
}

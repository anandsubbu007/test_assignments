// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';

import 'custom_inner_content.dart';

class CustomScrollViewContent extends StatelessWidget {
  final ScrollController scrollController;
  const CustomScrollViewContent({Key? key, required this.scrollController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.only(
        topLeft: Radius.circular(24), topRight: Radius.circular(28));
    return Card(
      margin: EdgeInsets.zero,
      elevation: 12.0,
      shape: RoundedRectangleBorder(borderRadius: radius),
      child: Container(
        decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Color.fromARGB(255, 65, 134, 232),
                Color.fromARGB(255, 49, 63, 112)
              ],
            ),
            borderRadius: radius,
            color: Colors.blue),
        child: SingleChildScrollView(
            controller: scrollController, child: CustomInnerContent()),
      ),
    );
  }
}

import 'package:flutter/material.dart';

extension ContextExt on BuildContext {
  TextTheme get textTheme {
    return Theme.of(this).textTheme;
  }

  Size get mediaSize => MediaQuery.of(this).size;

  double htP(int percent) {
    return mediaSize.height * (percent / 100);
  }
  double wtP(int percent) {
    return mediaSize.width * (percent / 100);
  }
}

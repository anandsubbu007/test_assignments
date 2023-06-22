import 'package:flutter/material.dart';

extension LocaleContextExt on BuildContext {
  TextTheme get textThem {
    return Theme.of(this).textTheme;
  }

  ColorScheme get color => Theme.of(this).colorScheme;
  Size get appSize => MediaQuery.of(this).copyWith(textScaleFactor: 1).size;

  double htP(double percent) => appSize.height * percent / 100;
  double wdP(double percent) => appSize.width * percent / 100;
}

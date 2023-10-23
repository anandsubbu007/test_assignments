import 'package:flutter/material.dart';

class AppColor {
  static Color focused = (fromHex("FBAA29"));
  static Color disabled = focused.withOpacity(.5);
  static Color baground = Colors.black;
  static Color foreGround = Colors.white;
  static Color textFieldBg = (fromHex("F4F6F9"));
  static Color textFieldHint = (fromHex("DADADA"));
  // #


  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}

int hexToInteger(String hex) => int.parse(hex, radix: 16);

extension HexColor on Color {}

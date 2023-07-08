import 'package:flutter/material.dart';

extension StringExt on String {
  Map<String, String> parseLink() {
    final out = <String, String>{};
    final parts = split(', ');
    for (final part in parts) {
      if (part[0] != '<') {
        throw const FormatException('Invalid Link Header');
      }
      final kv = part.split('; ');
      var url = kv[0].substring(1);
      url = url.substring(0, url.length - 1);
      var key = kv[1];
      key = key.replaceAll('"', '').substring(4);
      out[key] = url;
    }
    return out;
  }

  Color getColorForStatus() {
    if (this == "Success") {
      return Colors.green;
    } else if (this == "Pending") {
      return Colors.orange;
    } else if (this == "Error") {
      return Colors.red;
    } else {
      return Colors.black;
    }
  }
}

import 'package:flutter/cupertino.dart';

class ValidationUtils {
  ValidationUtils._();



  static bool isEmail(String email) {
    String passwordValidationRule =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(passwordValidationRule);
    return regExp.hasMatch(email);
  }

  static bool isValidString(String value) {
    return (value.trim().isNotEmpty);
  }

  static bool isValid(String value, String regex) {
    if (value.isNotEmpty) {
      RegExp regExp = RegExp(regex);
      return regExp.hasMatch(value);
    } else {
      return false;
    }
  }

  static String? validate(String? args, String field, BuildContext context) {
    if (args?.isEmpty ?? true) {
      return "$field Cannot be blank";
    } else {
      return null;
    }
  }
}

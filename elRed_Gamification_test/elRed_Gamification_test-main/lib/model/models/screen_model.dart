// ignore_for_file: depend_on_referenced_packages, unnecessary_this

import 'dart:convert';

import 'package:collection/collection.dart';

// ignore_for_file: non_constant_identifier_names

class Screen {
  String screen_name;
  String heading;
  String question;
  String hint_text;
  List<Fields> fields;
  List<Options> options;
  String? ans;
  Map<String, List<Screen>> child_screen;
  String? parentScreen;

  Screen({
    required this.screen_name,
    required this.heading,
    required this.question,
    required this.hint_text,
    required this.fields,
    required this.options,
    this.ans,
    required this.child_screen,
  });

  factory Screen.fromMap(Map<String, dynamic> map) {
    Map<String, List<Screen>> child_screen = {};
    final screenName = map['screen_name'] ?? '';
    if (map['child_screen'] != null) {
      Map child = map['child_screen'];
      child.forEach((key, value) {
        child_screen[key] = List<Screen>.from(
            value?.map((x) => Screen.fromMap(x)..parentScreen = screenName) ??
                []);
      });
    }
    return Screen(
        screen_name: screenName,
        heading: map['heading'] ?? '',
        question: map['question'] ?? '',
        hint_text: map['hint_text'] ?? '',
        fields: List<Fields?>.from(map['fields']?.map((x) =>
                    Fields.values.firstWhereOrNull((e) => e.value == x)) ??
                [])
            .whereNotNull()
            .toList(),
        options: List<Options>.from(
            map['options']?.map((x) => Options.fromMap(x)) ?? []),
        ans: map['ans'],
        child_screen: child_screen);
  }
  factory Screen.fromJson(String source) => Screen.fromMap(json.decode(source));

  // factory Screen.fromMap(Map<String, dynamic> map) {
  //   return Screen(
  //     screen_name: map['screen_name'] ?? '',
  //     heading: map['heading'] ?? '',
  //     question: map['question'] ?? '',
  //     hint_text: map['hint_text'] ?? '',
  //     fields: List<Fields>.from(map['fields']?.map((x) => Fields.fromMap(x))),
  //     options: List<Options>.from(map['options']?.map((x) => Options.fromMap(x))),
  //     ans: map['ans'],
  //     child_screen: Map<String, Screen>.from(map['child_screen']),
  //   );
  // }
}

enum Fields {
  textField("textfield"),
  datefield('datefield'),
  radio("radio");

  final String value;
  const Fields(this.value);

  bool get isTextBox => [textField, datefield].contains(this);
}

class Options {
  String key;
  String text;
  String value;
  Options({
    required this.key,
    required this.text,
    required this.value,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'key': key});
    result.addAll({'text': text});
    result.addAll({'value': value});

    return result;
  }

  factory Options.fromMap(Map<String, dynamic> map) {
    return Options(
      key: map['key'] ?? '',
      text: map['text'] ?? '',
      value: map['value'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Options.fromJson(String source) =>
      Options.fromMap(json.decode(source));
}

extension ScreenExt on Screen {
  String get getHeading {
    return this.heading;
  }

  String get getQuestion {
    return this.question;
  }

  bool get isTextField {
    return fields.contains(Fields.textField) ||
        fields.contains(Fields.textField);
  }
}

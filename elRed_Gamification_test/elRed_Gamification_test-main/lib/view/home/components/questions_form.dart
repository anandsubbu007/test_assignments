// ignore_for_file: depend_on_referenced_packages

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_app/model/models/screen_model.dart';
import 'package:flutter_app/utils/constant/color_utils.dart';
import 'package:flutter_app/view/widget/app_text_field.dart';
import 'package:flutter_app/view/widget/radio_choice.dart';
import 'package:flutter_app/view_model/provider/home_page_control.dart';

class QuestionsForm extends StatelessWidget {
  const QuestionsForm({super.key});

  @override
  Widget build(BuildContext context) {
    final question = context.select((HomePageControl value) => value.question);
    final messages = context.select((HomePageControl value) => value.messages);

    final fields = context.select((HomePageControl value) => value.fields);
    final model = context.read<HomePageControl>();
    return Container(
      padding: const EdgeInsets.fromLTRB(2, 12, 2, 8),
      color: Colors.white,
      child: Form(
        key: model.formkey,
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          if (messages.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RichText(
                text: TextSpan(
                    text: " ",
                    style: context.textTheme.titleMedium!
                        .copyWith(color: AppColor.baground),
                    children: messages),
                textAlign: TextAlign.left,
              ),
            ),
          if (question.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
              child: Text(
                question,
                textAlign: TextAlign.left,
                style: context.textTheme.headlineSmall!.copyWith(
                    fontWeight: FontWeight.w500, color: AppColor.focused),
              ),
            ),
          Expanded(
              child: ListView(
            padding: const EdgeInsets.all(5),
            children: fields.map((e) => HomeFormField(field: e)).toList(),
          ))
        ]),
      ),
    );
  }
}

class HomeFormField extends StatelessWidget {
  final Fields field;
  const HomeFormField({super.key, required this.field});

  @override
  Widget build(BuildContext context) {
    final fieldVal =
        context.select((HomePageControl value) => value.fieldValue(field));
    if (field.isTextBox) {
      final hintText =
          context.select((HomePageControl value) => value.hintText);
      return AppTextField(
        hintText: hintText ?? "",
        textField: field,
        initialValue: fieldVal,
        onChange: (p) {
          context.read<HomePageControl>().onChangeText(p);
        },
      );
    } else if (field == Fields.radio) {
      final options = context.select((HomePageControl value) => value.options);
      return RadioOptions(
          options: options,
          initial: options.firstWhereOrNull((e) => e.value == fieldVal),
          onChange: (o) async {
            context.read<HomePageControl>().onChangeText(o.value);
            return true;
          });
    } else {
      return const SizedBox();
    }
  }
}

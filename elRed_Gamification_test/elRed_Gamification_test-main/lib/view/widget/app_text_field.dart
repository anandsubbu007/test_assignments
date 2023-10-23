import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_app/model/models/screen_model.dart';
import 'package:flutter_app/utils/constant/color_utils.dart';
import 'package:intl/intl.dart';

/// App Text Field
class AppTextField extends StatefulWidget {
  final String hintText;
  final String? initialValue;
  final Function(String) onChange;
  final Fields textField;
  const AppTextField({
    super.key,
    required this.hintText,
    this.initialValue,
    required this.onChange,
    this.textField = Fields.textField,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  final focusNode = FocusNode();
  bool isVisible = false;
  void selectDate() async {
    if (isVisible) return;
    isVisible = true;
    final onSelect = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1800),
        lastDate: DateTime.now());
    isVisible = false;
    focusNode.unfocus();
    if (onSelect != null) {
      contrl.text = DateFormat('dd/MM/yyyy').format(onSelect);
      widget.onChange(contrl.text);
    }
  }

  late TextEditingController contrl;
  @override
  Widget build(BuildContext context) {
    bool isDateField = widget.textField == Fields.datefield;
    contrl = TextEditingController(text: widget.initialValue);
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColor.textFieldBg,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Stack(
        children: [
          TextFormField(
            focusNode: focusNode,
            validator: (v) {
              if ((v ?? '').isEmpty) return "This must not be empty";
              if (v!.length > 60) return "Max 60 char";
              return null;
            },
            readOnly: isDateField,
            controller: contrl,
            // initialValue: initialValue,
            onChanged: widget.onChange,
            style: context.textTheme.titleMedium
                ?.copyWith(color: AppColor.baground),
            cursorColor: AppColor.baground,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColor.baground),
                  borderRadius: BorderRadius.circular(5),
                ),
                hintText: widget.hintText,
                hintStyle: context.textTheme.titleMedium
                    ?.copyWith(color: AppColor.textFieldHint)),
          ),
          if (isDateField)
            Positioned.fill(
                child: InkWell(
              onTap: selectDate,
              child: const SizedBox(),
            ))
        ],
      ),
    );
  }
}

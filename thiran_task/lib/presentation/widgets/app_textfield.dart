// import '/utilities/layout.dart';
import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final int maxCount = 0;
  final String label;
  final String hint;
  final String helperText;
  final bool autoFocus = false;
  final FormFieldValidator<String>? validator;
  final EdgeInsets margin;
  final TextInputType textInputType;
  final TextEditingController controller;
  final bool readOnly;
  final FocusNode? focusNode;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmited;
  final VoidCallback? onTap;
  final EdgeInsets customPadding = EdgeInsets.zero;
  final TextStyle style = const TextStyle();
  final TextStyle? readOlyStyle;
  final Widget? prefixIcon;
  final Widget suffixIcon = const Icon(Icons.add, color: Colors.transparent);
  final EdgeInsetsGeometry contentPadding =
      const EdgeInsets.only(top: 0.0, left: 0.0, bottom: 10.0, right: 0.0);
  const AppTextField(
      {super.key,
      required this.controller,
      this.label = "",
      this.textInputType = TextInputType.text,
      this.prefixIcon,
      this.margin =
          const EdgeInsets.only(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0),
      this.helperText = "",
      this.hint = "",
      this.readOnly = false,
      this.focusNode,
      this.validator,
      this.onChanged,
      this.onSubmited,
      this.onTap,
      this.readOlyStyle});

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.centerLeft,
        padding: customPadding,
        margin: margin,
        child: TextFormField(
          readOnly: readOnly,
          onTap: onTap,
          focusNode: focusNode,
          controller: controller,
          textAlign: TextAlign.left,
          keyboardType: textInputType,
          maxLength: null,
          obscuringCharacter: "*",
          autofocus: autoFocus,
          style: readOnly
              ? (readOlyStyle ?? TextStyle(color: Colors.grey[600]))
              : style,
          decoration: InputDecoration(
              errorMaxLines: 2,
              helperText: helperText.trim().isEmpty ? null : helperText,
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
              labelStyle: const TextStyle(height: 1),
              hintStyle: TextStyle(color: Colors.black.withOpacity(0.7)),
              contentPadding: const EdgeInsets.all(8),
              labelText: hint),
          validator: validator,
          onChanged: onChanged,
          onFieldSubmitted: onSubmited,
        ));
  }
}

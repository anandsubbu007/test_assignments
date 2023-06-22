import 'package:employee_app/utils/constant/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    Key? key,
    required this.label,
    this.controller,
    this.errorMessage,
    this.keyboardType,
    this.onTap,
    this.readOnly,
    this.maxLines,
    this.textInputAction,
    this.hint,
    this.autoFocus = false,
    this.inputFormatters,
    this.enabled,
    this.maxLength,
    this.floatingLabelBehavior,
    this.validator,
    this.onChanged,
    this.suffixIcon,
    this.icon,
    this.textDirection,
    this.bottomSpace,
    this.autovalidateMode,
  }) : super(key: key);
  final String label;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final Function(String value)? validator;
  final String? errorMessage;
  final bool? readOnly;
  final Function()? onTap;
  final int? maxLines;
  final bool autoFocus;
  final String? hint;
  final TextInputAction? textInputAction;
  final bool? enabled;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final FloatingLabelBehavior? floatingLabelBehavior;
  final Function(String value)? onChanged;
  final Widget? suffixIcon;
  final Widget? icon;
  final TextDirection? textDirection;
  final double? bottomSpace;
  final AutovalidateMode? autovalidateMode;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: autoFocus,
      readOnly: readOnly ?? false,
      enabled: enabled ?? true,
      textInputAction: textInputAction ?? TextInputAction.next,
      inputFormatters: inputFormatters,
      autovalidateMode: autovalidateMode,
      textDirection: textDirection,
      onTap: onTap,
      validator: validator != null
          ? (value) {
              if (!validator?.call(value ?? "")) {
                if (errorMessage == null) {
                  return "Please enter a valid Input";
                } else {
                  return errorMessage;
                }
              }
              return null;
            }
          : null,
      style: const TextStyle(fontSize: 14),
      controller: controller,
      maxLines: maxLines ?? 1,
      maxLength: maxLength,
      onChanged: onChanged,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        filled: true,
        prefixIcon: icon,
        prefixIconConstraints: const BoxConstraints(
            maxHeight: 24, minWidth: 35, minHeight: 24, maxWidth: 35),
        suffixIcon: suffixIcon,
        suffixIconConstraints: const BoxConstraints(
            maxHeight: 20, minWidth: 35, minHeight: 20, maxWidth: 35),
        isDense: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(vertical: 13),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.borderGrey),
        ),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.borderGrey)),
        hintText: hint ?? label,
        floatingLabelBehavior: floatingLabelBehavior,
        hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
      ),
    );
  }
}

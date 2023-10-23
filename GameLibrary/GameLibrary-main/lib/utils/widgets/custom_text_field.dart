import 'package:flutter/material.dart';
///  CustomTextField
class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    this.hint = "",
    this.controller,
    this.onChange,
    this.focusNode,
  }) : super(key: key);

  final String hint;
  final TextEditingController? controller;
  final Function(String?)? onChange;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      alignment: Alignment.center,
      height: 50,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(.05),
            spreadRadius: .5,
            blurRadius: .5,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: TextFormField(
        key: const Key('searchField'),
        autofocus: false,
        onChanged: onChange,
        controller: controller,
        focusNode: focusNode,
        style: textTheme.titleMedium,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.search),
          border: InputBorder.none,
          hintText: hint,
          hintStyle: textTheme.titleMedium,
        ),
      ),
    );
  }
}

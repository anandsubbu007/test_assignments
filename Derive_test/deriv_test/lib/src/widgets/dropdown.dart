import 'package:flutter/material.dart';

class AppDropDown<T> extends StatefulWidget {
  final String titles;
  final List<DropdownMenuItem<T>> items;
  final T? selected;
  final Future<bool> Function(T?) onChange;
  const AppDropDown(
      {super.key,
      required this.items,
      required this.onChange,
      this.selected,
      required this.titles});

  @override
  State<AppDropDown<T>> createState() => _AppDropDownState<T>();
}

class _AppDropDownState<T> extends State<AppDropDown<T>> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
        child: DropdownButtonHideUnderline(
            child: DropdownButtonFormField<T>(
          items: widget.items,
          decoration: const InputDecoration(border: OutlineInputBorder()),
          hint: Text(widget.titles),
          value: widget.selected,
          onChanged: (s) async {
            final canI = await widget.onChange(s);
            if (canI) {
              setState(() {});
            }
          },
        )));
  }
}

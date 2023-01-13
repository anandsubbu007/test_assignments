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
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4), border: Border.all()),
          child: DropdownButtonHideUnderline(
              child: DropdownButton<T>(
            items: widget.items,
            key: Key(widget.titles),
            // decoration: const InputDecoration(border: OutlineInputBorder()),
            hint: Text(widget.titles),
            value: widget.selected,
            onChanged: (s) async {
              final canI = await widget.onChange(s);
              if (canI) {
                setState(() {});
              }
            },
          )),
        ));
  }
}

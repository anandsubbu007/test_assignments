import 'package:flutter/material.dart';

import '../utilities/validation_utils.dart';
import 'app_textfield.dart';

class AppDropDownItem extends StatefulWidget {
  final ValueChanged<String> onChange;
  final bool hideRulerLine;
  final List<String> dropDownItems;
  final String name;

  const AppDropDownItem(this.name,
      {super.key,
      required this.onChange,
      required this.dropDownItems,
      this.hideRulerLine = false});
  @override
  AppDropDownItemState createState() => AppDropDownItemState();
}

class AppDropDownItemState extends State<AppDropDownItem> {
  String? value;

  @override
  Widget build(BuildContext context) {
    final field = AppTextField(
        controller: TextEditingController(),
        prefixIcon: const Padding(
            padding: EdgeInsets.all(12),
            child: Icon(Icons.monetization_on_outlined)),
        textInputType: TextInputType.text,
        margin: EdgeInsets.zero,
        onTap: () {},
        validator: (arg) {
          if (value == null) {
            return ValidationUtils.validate(arg, widget.name, context);
          }
          return null;
        });
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Stack(
          children: [
            Padding(padding: const EdgeInsets.only(top: 5), child: field),
            Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 7),
                child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                        isExpanded: true,
                        iconSize: 30,
                        hint: Row(children: [
                          const SizedBox(
                            width: 24,
                          ),
                          Text(value == null ? "Select ${widget.name}" : value!,
                              style: TextStyle(
                                  fontSize: 16,
                                  color: value == null ? null : Colors.black)),
                        ]),
                        items: widget.dropDownItems.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Row(children: [
                              const SizedBox(
                                width: 24,
                              ),
                              Text(value,
                                  style: const TextStyle(
                                      fontSize: 16, color: Colors.black))
                            ]),
                          );
                        }).toList(),
                        onChanged: (arg) {
                          FocusScope.of(context).requestFocus(FocusNode());
                          value = arg!;
                          widget.onChange(arg);
                        }))),
          ],
        ),
      ],
    );
  }
}

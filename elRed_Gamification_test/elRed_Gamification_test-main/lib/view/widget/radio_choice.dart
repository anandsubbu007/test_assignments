import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_app/model/models/screen_model.dart';
import 'package:flutter_app/utils/constant/color_utils.dart';

class RadioOptions extends StatefulWidget {
  final List<Options> options;
  final Options? initial;
  final Future<bool> Function(Options) onChange;
  const RadioOptions(
      {super.key, required this.options, this.initial, required this.onChange});

  @override
  State<RadioOptions> createState() => _RadioOptionsState();
}

class _RadioOptionsState extends State<RadioOptions> {
  Options? selected;
  @override
  void initState() {
    selected = widget.initial;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      child: Wrap(
          spacing: 8,
          runSpacing: 8,
          alignment: WrapAlignment.start,
          children: widget.options.map((e) {
            bool isSelected = e.value == selected?.value;
            final color = isSelected ? AppColor.focused : AppColor.baground;
            return InkWell(
              onTap: () async {
                final canI = await widget.onChange(e);
                if (canI) {
                  setState(() {
                    selected = e;
                  });
                }
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                        isSelected
                            ? Icons.radio_button_checked
                            : Icons.radio_button_off,
                        color: color),
                    const SizedBox(width: 6),
                    Text(
                      e.text,
                      style:
                          context.textTheme.titleMedium!.copyWith(color: color),
                    ),
                  ],
                ),
              ),
            );
          }).toList()),
    );
  }
}

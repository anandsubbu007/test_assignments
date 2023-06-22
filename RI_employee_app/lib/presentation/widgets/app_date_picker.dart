import 'package:employee_app/presentation/widgets/date_btn.dart';
import 'package:employee_app/utils/constant/assets.dart';
import 'package:employee_app/utils/extensions/date_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import 'footer_btn.dart';

class AppDatePicker extends StatefulWidget {
  final Function(DateTime dateTime) onSelected;
  final DateTime? startDate;
  final DateTime? selectedDate;
  final bool isOptional;

  const AppDatePicker(
      {super.key,
      required this.isOptional,
      required this.onSelected,
      this.startDate,
      this.selectedDate});

  @override
  State<AppDatePicker> createState() => _AppDatePickerState();
}

class _AppDatePickerState extends State<AppDatePicker> {
  DateRangePickerController controller = DateRangePickerController();

  @override
  void initState() {
    if (widget.selectedDate != null) {
      controller.displayDate = widget.selectedDate;
      controller.selectedDate = widget.selectedDate;
    }
    controller.addPropertyChangedListener((p0) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {});
      });
    });
    super.initState();
  }

  onDateSelected() {
    if (controller.selectedDate != null) {
      widget.onSelected(controller.selectedDate!);
    }

    Navigator.pop(context);
  }

  @override
  void dispose() {
    controller.removePropertyChangedListener((p0) {});
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: dayHints(),
          ),
          const SizedBox(height: 5),

          // Month selector
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    controller.backward?.call();
                  });
                },
                icon: SvgPicture.asset(
                  AppIcons.icPrev,
                  height: 20,
                ),
              ),
              Text(
                DateFormat('MMMM yyyy')
                    .format(controller.displayDate ?? DateTime.now()),
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    controller.forward?.call();
                  });
                },
                icon: SvgPicture.asset(
                  AppIcons.icNext,
                  height: 20,
                ),
              ),
            ],
          ),
          const SizedBox(height: 3),

          // Calendar Picker
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SfDateRangePicker(
              initialDisplayDate: widget.startDate ?? DateTime.now(),
              initialSelectedDate: widget.isOptional ? null : DateTime.now(),
              minDate: widget.startDate,
              controller: controller,
              headerHeight: 0,
              monthViewSettings: const DateRangePickerMonthViewSettings(
                dayFormat: "EEE",
                viewHeaderStyle: DateRangePickerViewHeaderStyle(
                    backgroundColor: Colors.transparent,
                    textStyle: TextStyle(fontSize: 11, color: Colors.black)),
              ),
              onSelectionChanged: (dateRangePickerSelectionChangedArgs) {
                setState(() {
                  // selectedIndex = -1;
                });
              },
            ),
          ),
          const SizedBox(height: 5),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SvgPicture.asset(AppIcons.icDate, height: 25),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    controller.selectedDate == null
                        ? "No Date"
                        : (controller.selectedDate ?? DateTime.now()).toDMMMY,
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
                ActionButton(
                  title: "Cancel",
                  isDense: true,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  fontColor: Colors.blue,
                  color: Colors.blue.withOpacity(.12),
                ),
                const SizedBox(width: 10),
                ActionButton(
                  isDense: true,
                  title: "Save",
                  onPressed: () {
                    onDateSelected();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget dayHints() {
    Widget today() => DateBtn(
          isSelected: controller.selectedDate?.isToday ?? false,
          title: "Today",
          onPressed: () {
            setState(() {
              controller.displayDate = DateTime.now();
              controller.selectedDate = DateTime.now();
            });
          },
        );
    Widget clearDate() => DateBtn(
          isSelected: controller.selectedDate == null,
          title: "No date",
          onPressed: () {
            setState(() {
              controller.selectedDate = null;
            });
          },
        );
    Widget nextMonday() => DateBtn(
          isSelected:
              controller.selectedDate?.isNextDay(DateTime.monday) ?? false,
          title: "Next Monday",
          onPressed: () {
            setState(() {
              var newDate = DateTime.now().next(DateTime.monday);
              controller.displayDate = newDate;
              controller.selectedDate = newDate;
            });
          },
        );
    Widget nestTuesday() => DateBtn(
          isSelected:
              controller.selectedDate?.isNextDay(DateTime.tuesday) ?? false,
          title: "Next Tuesday",
          onPressed: () {
            setState(() {
              var newDate = DateTime.now().next(DateTime.tuesday);
              controller.displayDate = newDate;
              controller.selectedDate = newDate;
            });
          },
        );
    Widget nextWeek() => DateBtn(
          isSelected: DateTime.now().add(const Duration(days: 7)).toDMMMY ==
              controller.selectedDate?.toDMMMY,
          title: "After 1 week",
          onPressed: () {
            setState(() {
              var newDate = DateTime.now().add(const Duration(days: 7));
              controller.displayDate = newDate;
              controller.selectedDate = newDate;
            });
          },
        );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (widget.isOptional) Expanded(child: clearDate()),
              Expanded(child: today()),
              if (!widget.isOptional) Expanded(child: nextMonday())
            ],
          ),
        ),
        if (!widget.isOptional)
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(child: nestTuesday()),
                Expanded(child: nextWeek())
              ],
            ),
          )
      ],
    );
  }
}

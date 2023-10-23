import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  DateTime next(int day) {
    return add(
      Duration(
        days: (day - weekday) % DateTime.daysPerWeek,
      ),
    );
  }

  String get toDMMMY {
    return DateFormat('dd MMM yyyy').format(this);
  }

  String get toReadableDate {
    final now = DateTime.now();
    if (toDMMMY == now.toDMMMY) return "Today";
    return toDMMMY;
  }

  bool get isToday {
    final now = DateTime.now();
    return toDMMMY == now.toDMMMY;
  }

  bool isNextDay(int day) {
    final now = DateTime.now().next(day);
    return toDMMMY == now.toDMMMY;
  }
}

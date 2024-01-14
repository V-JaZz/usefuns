
import 'dart:math';

import 'package:collection/collection.dart';

import '../data/model/response/user_data_model.dart';

class TimeUtil {
  static String getTimeDifferenceString(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 0) {
      return "${difference.inDays} days ago";
    } else if (difference.inHours > 0) {
      return "${difference.inHours} hours ago";
    } else if (difference.inMinutes > 0) {
      return "${difference.inMinutes} minutes ago";
    } else {
      return "Just now";
    }
  }
}

class AgeCalculator {
  static int calculateAge(DateTime dob) {
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - dob.year;

    if (currentDate.month < dob.month ||
        (currentDate.month == dob.month && currentDate.day < dob.day)) {
      age--;
    }

    return age;
  }
}
class FixedLengthQueue<T> {
  final int maxLength;
  final List<T> _queue = [];

  FixedLengthQueue(this.maxLength);

  void enqueue(T item) {
    if (_queue.length >= maxLength) {
      _queue.removeAt(0); // Remove the oldest item
    }
    _queue.add(item);
  }

  T? dequeue() {
    if (_queue.isNotEmpty) {
      return _queue.removeAt(0);
    }
    return null;
  }

  T? clear() {
    while (_queue.isNotEmpty) {
      _queue.removeAt(0);
    }
    return null;
  }

  T? elementAt(int index) {
    if (index >= 0 && index < _queue.length) {
      return _queue[index];
    }
    return null;
  }

  T? operator [](int index) {
    if (index >= 0 && index < _queue.length) {
      return _queue[index];
    }
    return null;
  }

  int get length => _queue.length;
}

bool isToday(DateTime dateToCheck) {
  DateTime now = DateTime.now();
  return dateToCheck.year == now.year &&
      dateToCheck.month == now.month &&
      dateToCheck.day == now.day;
}

bool inLastSevenDays(DateTime dateToCheck) {
  DateTime now = DateTime.now();
  DateTime sevenDaysAgo = now.subtract(const Duration(days: 7));

  return dateToCheck.isAfter(sevenDaysAgo) && dateToCheck.isBefore(now);
}

String userFrameViewPath(List<ItemModel>? frame){
  if(frame==null) return '';
  if(frame.isEmpty) return '';
  if(frame.firstWhereOrNull((e) => e.defaultFrame??false) != null){
    return frame.firstWhere((e) => e.defaultFrame??false).images?.last??'';
  }
  if(frame.isNotEmpty) return frame.first.images?.last??'';
  return '';
}

String formatNumber(int number) {
  if (number.abs() < 1000) {
    return number.toString();
  }
  const suffixes = ["", "K", "M", "B", "T", "P", "E", "Z", "Y"];

  int magnitude = (log(number.abs()) / log(10) / 3).floor();
  double shortenedNumber = number / pow(10, magnitude * 3);

  String formattedNumber = shortenedNumber.toStringAsFixed(1);

  if (formattedNumber.endsWith('.0')) {
    formattedNumber = formattedNumber.substring(0, formattedNumber.length - 2);
  }

  return '$formattedNumber${suffixes[magnitude]}';
}
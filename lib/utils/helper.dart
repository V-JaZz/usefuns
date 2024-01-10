
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

String getCountryByMobileNo(int? mobileNo, {bool name = false}){
  if(mobileNo==null) return '';
  String getCountryCode(String phoneNumber) {
    int countryCodeLength = phoneNumber.length - 10;
    return phoneNumber.substring(0, countryCodeLength);
  }
  String code = getCountryCode(mobileNo.toString());
  switch(code){
    case '91':
      return name?'India':'assets/in_flag.png';
    case '92':
      return name?'Pakistan':'assets/pk_flag.png';
    case '880':
      return name?'Bangladesh':'assets/bd_flag.png';
  }
  return '';
}

String formatInt(int value) {
  if (value >= 1000) {
    double convertedValue = value / 1000;
    String formattedValue = convertedValue.toStringAsFixed(convertedValue.truncateToDouble() == convertedValue ? 0 : 1);
    return '${formattedValue}k';
  } else {
    return value.toString();
  }
}
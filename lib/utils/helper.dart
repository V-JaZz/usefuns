
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
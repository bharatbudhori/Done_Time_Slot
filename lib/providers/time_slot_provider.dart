import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class TimeSlotProvider extends ChangeNotifier {
  List<String> selectedTime = [];
  

  //generate a list of time given a start time and end time and interval
  List<String> generateTimeList(
      {required String startTime,
      required String endTime,
      required int interval}) {
    List<String> timeList = [];
    var start = DateFormat('HH:mm').parse(startTime);
    var end = DateFormat('HH:mm').parse(endTime);
    var diff = end.difference(start);
    var minutes = diff.inMinutes;
    var count = minutes ~/ interval;
    for (var i = 0; i <= count; i++) {
      var time = start.add(Duration(minutes: interval * i));
      timeList.add(DateFormat('HH:mm').format(time));
    }
    return timeList;
  }

  void addRemoveTime(String time) {
    if (selectedTime.contains(time)) {
      selectedTime.remove(time);
    } else {
      selectedTime.add(time);
    }
    notifyListeners();
  }

  String displayMessage({required DateTime selectedDate}) {
    if (selectedDate.day == DateTime.now().day &&
        selectedDate.month == DateTime.now().month &&
        selectedDate.year == DateTime.now().year) {
      return 'today';
    } else if (selectedDate.day == DateTime.now().day + 1 &&
        selectedDate.month == DateTime.now().month &&
        selectedDate.year == DateTime.now().year) {
      return 'tomorrow';
    } else if (selectedDate.day == DateTime.now().day + 2 &&
        selectedDate.month == DateTime.now().month &&
        selectedDate.year == DateTime.now().year) {
      return 'day after tomorrow';
    } else {
      return DateFormat('EEEE, MMMM d, yyyy').format(selectedDate);
    }
  }

  bool isSectionSelected(List<String> time) {
    for (var i = 0; i < time.length; i++) {
      if (!selectedTime.contains(time[i])) {
        return false;
      }
    }
    return true;
  }

  selectAllSection(time) {
    for (var element in time) {
      if (!selectedTime.contains(element)) {
        selectedTime.add(element);
      }
    }
    notifyListeners();
  }
}

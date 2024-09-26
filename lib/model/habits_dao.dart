import 'dart:io';

import 'package:habit_tracker/model/date_dao.dart';
import 'package:habit_tracker/model/habit.dart';

class HabitsDAO {
  static File get _localFile {
    return File("${Directory.current.path}/habits.txt");
  }

  static Future<File> writeHabitRecords(List<Habit> habitList) {
    String records = "${DateDAO.todayString}\n";

    for (Habit habit in habitList) {
      records += "${habit.toRecord()}\n";
    }
    final file = _localFile;
    return file.writeAsString(records);
  }

  static Future<List<Habit>> readHabitRecords() async {
    final file = _localFile;
    if (!(await file.exists())) {
      return [];
    }

    List<String> records = await file.readAsLines();
    String recordsDate = records[0];
    List<Habit> habits = [];

    if (recordsDate == DateDAO.todayString) {
      for (String record in records.sublist(1)) {
        habits.add(Habit.fromTodayRecord(record));
      }
    } else {
      for (String record in records.sublist(1)) {
        habits.add(Habit.fromOldRecord(record));
      }
    }

    return habits;
  }
}

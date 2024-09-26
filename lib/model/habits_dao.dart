import 'dart:io';

import 'package:flutter/material.dart';
import 'package:habit_tracker/model/date_dao.dart';
import 'package:habit_tracker/model/habit.dart';

class HabitsDAO {
  /// Setter that configures a listener for a milestone-achieved event in some
  /// habit after several days of streak.
  static set onStreakMilestoneAchieved(void Function(Habit) listener) {
    _onStreakMilestoneAchieved = listener;
  }

  /// Reads and returns the saved data of previous session's habit records.
  static Future<List<Habit>> loadHabits() async {
    final file = _localFile;
    if (!(await file.exists())) {
      return [];
    }

    List<String> records = await file.readAsLines();
    String recordsDate = records[0];
    int daysPassed = DateDAO.daysFrom(recordsDate);
    List<Habit> habitsCopy = [];

    for (String record in records.sublist(1)) {
      List<String> tokens = record.split(_tokenSeparator);

      String name = tokens[0];

      List<bool> history = List.filled(8, false);
      if (daysPassed < 8) {
        int i = 0;
        for (String s in tokens[1].substring(daysPassed).characters) {
          history[i] = s == "1";
          ++i;
        }
      }

      int streak = 0;
      if (daysPassed < 1 || history[6]) {
        streak = int.parse(tokens[2]);
      }

      Habit habit = Habit.fromRecordData(name, history, streak);

      _habits.add(habit);
      habitsCopy.add(habit.copy());
    }

    return habitsCopy;
  }

  /// Registers a new habit with the specified name in the records.
  static Habit createHabit(String name) {
    Habit newHabit = Habit(name);
    _habits.add(newHabit);
    return newHabit.copy();
  }

  /// Updates the record of the indexed habit after marking or unmarking it today.
  static bool toggleHabitMarkedToday(int index) {
    _habits[index].toggleMarkedToday();

    if (_habits[index].isMarkedToday() && _hasStreakReachedMilestone(index)) {
      Future.delayed(
        const Duration(milliseconds: 100),
        () {
          _onStreakMilestoneAchieved(_habits[index].copy());
        },
      );
    }

    return true;
  }

  /// Changes the name of the indexed habit to the specified one.
  static String renameHabit(int index, String name) {
    _habits[index].name = name;
    return _habits[index].name;
  }

  /// Removes the indexed habit from the records.
  static bool deleteHabit(int index) {
    _habits.removeAt(index);
    return true;
  }

  /// Saves the data of the current habit records for future sessions.
  static Future<void> saveHabits() async {
    String records = "${DateDAO.todayString}\n";
    for (Habit habit in _habits) {
      String record = "${habit.name}$_tokenSeparator";
      for (int i = 7; i > -1; --i) {
        record += habit.isMarkedNDaysAgo(i) ? "1" : "0";
      }
      record += "$_tokenSeparator${habit.streak}";

      records += "$record\n";
    }

    final file = _localFile;
    await file.writeAsString(records);
  }

  static final List<Habit> _habits = [];

  static File get _localFile {
    return File("${Directory.current.path}/habits.txt");
  }

  // Separator used for the habit records' tokenized strings.
  static const String _tokenSeparator = "\\";
  static late void Function(Habit) _onStreakMilestoneAchieved;

  /// Checks if the indexed habit's streak reached a milestone value.
  static bool _hasStreakReachedMilestone(int index) {
    int streak = _habits[index].streak;

    return (streak > 6) &&
        ((streak < 25 && streak % 7 == 0) || streak % 25 == 0);
  }
}

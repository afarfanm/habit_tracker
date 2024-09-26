import 'dart:io';

import 'package:flutter/material.dart';
import 'package:habit_tracker/model/alerts_dao.dart';
import 'package:habit_tracker/model/date_dao.dart';
import 'package:habit_tracker/model/habit.dart';

class HabitsDAO {
  /// Setter that establishes a listener for a habit created event in this model.
  static set onHabitListChanged(void Function(int) listener) {
    _onHabitListChanged = listener;
  }

  /// Setter that configures a listener for a milestone-achieved event in some
  /// habit after several days of streak.
  static set onStreakMilestoneAchieved(void Function(Habit) listener) {
    _onStreakMilestoneAchieved = listener;
  }

  /// Reads the saved data of previous session's habit records.
  static Future<void> init() async {
    final file = _localFile;
    if (!(await file.exists())) {
      return;
    }

    List<String> records = await file.readAsLines();
    String recordsDate = records[0];
    int daysPassed = DateDAO.daysFrom(recordsDate);

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

      int streak;
      int daysInterrumpted;

      if (daysPassed == 0) {
        streak = int.parse(tokens[2]);
        daysInterrumpted = int.parse(tokens[3]);
      } else if (history[6]) {
        streak = int.parse(tokens[2]);
        daysInterrumpted = 0;
      } else {
        streak = 0;
        daysInterrumpted = int.parse(tokens[3]) + daysPassed;
      }

      Habit habit = Habit.fromRecordData(
        name,
        history,
        streak,
        daysInterrumpted,
      );

      _habits.add(habit);

      if (daysInterrumpted > 6) {
        AlertsDAO.addAlert(habit);
      }
    }

    _onHabitListChanged(_habits.length);
    AlertsDAO.finishInitialization();
  }

  // Returns the key of the indexed habit used to differentiate it
  // in render times.
  static int getHabitRenderKey(int index) {
    return _habits[index].renderKey;
  }

  /// Returns the data of the indexed habit.
  static Habit fetchHabit(int index) {
    return _habits[index].copy();
  }

  /// Registers a new habit with the specified name in the records.
  static void createHabit(String name) {
    Habit newHabit = Habit(name);
    _habits.add(newHabit);

    Future.delayed(
      const Duration(milliseconds: 10),
      () => _onHabitListChanged(_habits.length),
    );
  }

  /// Updates the record of the indexed habit after marking or unmarking it today.
  static Future<void> toggleHabitMarkedToday(int index) async {
    _habits[index].toggleMarkedToday();

    if (_habits[index].isMarkedToday() && _hasStreakReachedMilestone(index)) {
      Future.delayed(
        const Duration(milliseconds: 100),
        () {
          _onStreakMilestoneAchieved(_habits[index].copy());
        },
      );
    }
  }

  /// Changes the name of the indexed habit to the specified one.
  static Future<void> renameHabit(int index, String name) async {
    _habits[index].name = name;
  }

  /// Removes the indexed habit from the records.
  static void deleteHabit(int index) {
    _habits.removeAt(index);
    Future.delayed(
      const Duration(milliseconds: 10),
      () => _onHabitListChanged(_habits.length),
    );
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
      record += "$_tokenSeparator${habit.daysInterrupted}";

      records += "$record\n";
    }

    final file = _localFile;
    await file.writeAsString(records);
  }

  static final List<Habit> _habits = [];

  static late final void Function(int) _onHabitListChanged;

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

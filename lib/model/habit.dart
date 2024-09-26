import 'package:flutter/material.dart';

class Habit {
  // Separator used for the habit records' tokenized strings.
  static const _tokenSeparator = "\\";

  late String name;
  late List<bool> history;

  Habit(this.name) {
    history = List.filled(8, false);
  }

  /// Interprets a record written today.
  Habit.fromTodayRecord(String record) {
    List<String> tokens = record.split(_tokenSeparator);
    List<bool> newHistory = List.filled(8, false);

    name = tokens[0];
    int i = 0;
    for (String s in tokens[1].characters) {
      newHistory[i] = s == "1";
      ++i;
    }
    history = newHistory;
  }

  /// Interprets a record written days ago.
  Habit.fromOldRecord(String record, int daysAgo) {
    List<String> tokens = record.split(_tokenSeparator);

    name = tokens[0];
    if (daysAgo > 7) {
      history = List.filled(8, false);
    } else {
      List<bool> newHistory = List.filled(8, false);
      int i = 0;
      for (String s in tokens[1].substring(daysAgo).characters) {
        newHistory[i] = s == "1";
        ++i;
      }
      history = newHistory;
    }
  }

  /// Creates a tokenized string to use as the record form of this habit.
  String toRecord() {
    String record = "$name$_tokenSeparator";
    for (int i = 0; i < 8; ++i) {
      record += history[i] ? "1" : "0";
    }
    return record;
  }

  bool getDoneToday() {
    return history[7];
  }

  void setDoneToday(bool done) {
    history[7] = done;
  }

  bool isMarkedAtHistory(int index) {
    return history[index];
  }
}

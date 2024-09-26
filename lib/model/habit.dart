class Habit {
  // Separator used for the habit records' tokenized strings.
  static const _tokenSeparator = "\\";

  late String name;
  late bool done;

  Habit(this.name, {this.done = false});

  /// Interprets a record written today.
  Habit.fromTodayRecord(String record) {
    List<String> tokens = record.split(_tokenSeparator);

    name = tokens[0];
    done = tokens[1] == "true";
  }

  /// Interprets a record written days ago.
  Habit.fromOldRecord(String record) {
    List<String> tokens = record.split(_tokenSeparator);

    name = tokens[0];
    done = false;
  }

  /// Creates a tokenized string to use as the record form of this habit.
  String toRecord() {
    return "$name$_tokenSeparator$done";
  }
}

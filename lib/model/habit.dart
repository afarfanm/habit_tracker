class Habit {
  Habit(this.name)
      : _history = List.filled(8, false),
        _streak = 0;

  Habit.fromRecordData(this.name, List<bool> history, int streak)
      : _history = history,
        _streak = streak;

  /// Identifier for this habit.
  String name;

  // Current streak count for this habit.
  int get streak => _streak;

  /// Checks if this habit is marked as done today or not.
  bool isMarkedToday() {
    return _history[7];
  }

  /// Checks if this habit was marked as done in the specificed date N days ago.
  /// Specifying 0 days ago is equivalent to using the isMarkedToday method.
  bool isMarkedNDaysAgo(int daysAgo) {
    return _history[7 - daysAgo];
  }

  /// Changes this habit state following its marking or unmarking for today.
  void toggleMarkedToday() {
    _history[7] = !_history[7];
    _streak += _history[7] ? 1 : -1;
  }

  /// Returns a deep copy of this habit.
  Habit copy() {
    String nameCopy = String.fromCharCodes(name.runes);
    List<bool> historyCopy = List.generate(_history.length, (i) => _history[i]);

    return Habit.fromRecordData(nameCopy, historyCopy, _streak);
  }

  final List<bool> _history;
  int _streak;
}

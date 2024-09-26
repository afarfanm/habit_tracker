class Habit {
  Habit(this.name)
      : _history = List.filled(8, false),
        _streak = 0,
        _daysInterrupted = 0,
        _id = _getInstanceId();

  Habit.fromRecordData(
      this.name, List<bool> history, int streak, int daysInterrupted)
      : _history = history,
        _streak = streak,
        _daysInterrupted = daysInterrupted,
        _id = _getInstanceId();

  /// Name assigned to this habit.
  String name;

  // Current streak count for this habit.
  int get streak => _streak;

  // Unique id for this habit.
  int get id => _id;

  // Days that this habit hasn't been marked.
  int get daysInterrupted => _daysInterrupted;

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

    return Habit._fromOriginalToCopy(
      nameCopy,
      historyCopy,
      _streak,
      _daysInterrupted,
      _id,
    );
  }

  // Private, full parameter constructor used to deep-copy this habit.
  Habit._fromOriginalToCopy(
    this.name,
    List<bool> history,
    int streak,
    int daysInterrupted,
    int id,
  )   : _history = history,
        _streak = streak,
        _daysInterrupted = daysInterrupted,
        _id = id;

  final List<bool> _history;
  final int _id;
  final int _daysInterrupted;
  int _streak;

  static int _nextInstanceId = 0;

  static int _getInstanceId() {
    return _nextInstanceId++;
  }
}

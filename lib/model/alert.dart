class Alert {
  Alert(String habitName, int daysInterrupted)
      : _habitName = habitName,
        _daysInterrupted = daysInterrupted;

  String get habitName => _habitName;

  int get daysInterrupted => _daysInterrupted;

  final String _habitName;
  final int _daysInterrupted;
}

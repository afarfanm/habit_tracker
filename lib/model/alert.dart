class Alert {
  Alert(int habitId, String habitName, int daysInterrupted)
      : _habitId = habitId,
        _habitName = habitName,
        _daysInterrupted = daysInterrupted;

  /// Id of the habit related to this alert.
  int get habitId => _habitId;

  /// Name of the habit related to this alert.
  String get habitName => _habitName;

  /// Days that the habit related to this alert has been interrupted.
  int get daysInterrupted => _daysInterrupted;

  final int _habitId;
  final String _habitName;
  final int _daysInterrupted;
}

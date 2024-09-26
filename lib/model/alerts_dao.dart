import 'package:habit_tracker/model/alert.dart';
import 'package:habit_tracker/model/habit.dart';

class AlertsDAO {
  /// Adds a listener to the alerts-detected event.
  static set onAlertsDetected(void Function() listener) {
    _alertsDetectedListener = listener;
  }

  /// Adds a new alert to the list based on the data of the passed habit.
  static void addAlert(Habit habit) {
    _alerts.add(Alert(habit.name, habit.daysInterrupted));
  }

  /// Finishes the initialization phase of this DAO and notifies
  /// potential listeners.
  static void finishInitialization() {
    if (_alerts.isNotEmpty) {
      _alertsDetectedListener();
    }
  }

  /// Returns the number of alerts registered in this DAO.
  static int numberOfAlerts() {
    return _alerts.length;
  }

  /// Returns the indexed registered alert.
  static Alert fetchAlert(int index) {
    return _alerts[index];
  }

  static final List<Alert> _alerts = [];
  static late final void Function() _alertsDetectedListener;
}

import 'package:habit_tracker/model/alert.dart';
import 'package:habit_tracker/model/habit.dart';

class AlertsDAO {
  static void addAlert(Habit habit) {
    _alerts.add(Alert(habit.name, habit.daysInterrupted));
  }

  static int numberOfAlerts() {
    return _alerts.length;
  }

  static Alert fetchAlert(int index) {
    return _alerts[index];
  }

  static final List<Alert> _alerts = [];
}

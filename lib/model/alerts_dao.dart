import 'package:habit_tracker/model/alert.dart';
import 'package:habit_tracker/model/habit.dart';

class AlertsDAO {
  /// Sets [listener] as the handler for the specified event, invoked when the
  /// alerts list emptiness changes, starting from the moment this DAO's
  /// initialization finishes and onwards.
  static set onAlertsPendingStateChanged(
      void Function(bool alertsPending) listener) {
    _alertsPendingStateChangedListener = listener;
  }

  /// Checks if [habit] needs an alert for the amount of days interrupted,
  /// if so, adds the alert to the list.
  static void checkHabitForAlert(Habit habit) {
    if (habitDataImpliesAlert(habit) && !(habit.isMarkedToday())) {
      _insertAlert(habit.id, habit.name, habit.daysInterrupted);
    }
  }

  /// Finishes the initialization phase of this DAO and notifies to the
  /// alerts-loaded listener.
  static void finishInitialization() {
    _alertsPendingStateChangedListener(_alerts.isNotEmpty);
  }

  /// Returns the number of alerts in the list.
  static int numberOfAlerts() {
    return _alerts.length;
  }

  /// Returns the alert at [index] position in the list.
  static Alert fetchAlert(int index) {
    return _alerts[index];
  }

  /// Checks if the alert list needs to be updated based on the [toggledHabit]
  /// and acts accordingly.
  static void updateAlertsAfterHabitToggle(Habit toggledHabit) {
    if (!habitDataImpliesAlert(toggledHabit)) {
      return;
    }

    if (toggledHabit.isMarkedToday()) {
      _discardAlert(toggledHabit.id);
    } else {
      _insertAlert(
        toggledHabit.id,
        toggledHabit.name,
        toggledHabit.daysInterrupted,
      );
    }
  }

  /// Checks if the alert list needs to be updated based on the [deletedHabit]
  /// and acts accordingly.
  static void updateAlertsAfterHabitDeletion(Habit deletedHabit) {
    if (!habitDataImpliesAlert(deletedHabit)) {
      return;
    }

    int deletedIndex = 0;
    while (_alerts[deletedIndex].habitId != deletedHabit.id) {
      ++deletedIndex;
    }
    _alerts.removeAt(deletedIndex);
  }

  static final List<Alert> _alerts = [];
  static late final void Function(bool alertsPending)
      _alertsPendingStateChangedListener;

  /// Checks if the information of [habit] suggests the existence of an alert,
  /// either an alert to be raised or already raised.
  static bool habitDataImpliesAlert(Habit habit) {
    return habit.daysInterrupted > 6;
  }

  /// Inserts a new alert with the specified parameters to the alerts list
  /// in its appropiate position considering the referenced [habitId]
  static void _insertAlert(
    int habitId,
    String habitName,
    int daysInterrupted,
  ) {
    Alert inserted = Alert(habitId, habitName, daysInterrupted);

    if (_alerts.isEmpty) {
      _alerts.add(inserted);
      _alertsPendingStateChangedListener(_alerts.isNotEmpty);
      return;
    }

    int lastLower = _alerts.length - 1;
    while (lastLower > -1 && _alerts[lastLower].habitId > habitId) {
      --lastLower;
    }
    _alerts.insert(lastLower + 1, inserted);
  }

  /// Removes the alert with the specified [habitId] from this list.
  static void _discardAlert(int habitId) {
    Alert removed = _alerts.firstWhere((alert) {
      return alert.habitId == habitId;
    });
    _alerts.remove(removed);

    if (_alerts.isEmpty) {
      _alertsPendingStateChangedListener(_alerts.isNotEmpty);
    }
  }
}

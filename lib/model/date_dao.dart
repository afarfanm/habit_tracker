class DateDAO {
  /// String representing today's date.
  static final String todayString = "${_time.day}/${_time.month}/${_time.year}";

  /// Obtains the day of the week and date of the last 7 days.
  static List<String> getLastWeekDays() {
    List<String> lastWeekDays = [];
    DateTime dateIterator = _time.subtract(const Duration(days: 7));

    for (int i = 0; i < 8; ++i) {
      lastWeekDays.add(
          "${_weekdays[dateIterator.weekday]} ${dateIterator.day > 9 ? dateIterator.day : "0${dateIterator.day}"}");
      dateIterator = dateIterator.add(const Duration(days: 1));
    }

    return lastWeekDays;
  }

  /// Calculates the days passed from the specified date in string format.
  static int daysFrom(String date) {
    List<String> tokens = date.split("/");
    DateTime pastDate = DateTime(
        int.parse(tokens[2]), int.parse(tokens[1]), int.parse(tokens[0]));
    return _time.difference(pastDate).inDays;
  }

  static final DateTime _time = DateTime.now();
  static final List<String> _weekdays = [
    "",
    "Mon",
    "Tue",
    "Wed",
    "Thu",
    "Fri",
    "Sat",
    "Sun"
  ];
}

class DateDAO {
  static final DateTime _time = DateTime.now();
  static final String todayString = "${_time.day}/${_time.month}/${_time.year}";
  static final List<String> weekdays = [
    "",
    "Mon",
    "Tue",
    "Wed",
    "Thu",
    "Fri",
    "Sat",
    "Sun"
  ];

  static List<String> getLastWeekDays() {
    List<String> lastWeekDays = [];
    DateTime dateIterator = _time.subtract(const Duration(days: 7));

    for (int i = 0; i < 7; ++i) {
      lastWeekDays.add(
          "${weekdays[dateIterator.weekday]}\n${dateIterator.day > 9 ? dateIterator.day : "0${dateIterator.day}"}");
      dateIterator = dateIterator.add(const Duration(days: 1));
    }

    return lastWeekDays;
  }
}

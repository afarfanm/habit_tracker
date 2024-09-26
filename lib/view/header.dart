import 'package:flutter/material.dart';
import 'package:habit_tracker/model/date_dao.dart';

class Header extends StatelessWidget {
  Header({super.key});

  final List<String> _weekDates = DateDAO.getLastWeekDays();

  final BoxDecoration _cellDecoration = BoxDecoration(
    border: Border.all(
      color: Colors.black,
      width: 0.5,
    ),
  );

  @override
  Widget build(BuildContext context) {
    TextStyle? headingStyle = Theme.of(context).textTheme.displaySmall;

    if (_weekDates.isEmpty) {
      for (int i = 0; i < 7; ++i) {
        _weekDates.add("Mon 01");
      }
    }

    return Expanded(
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: _cellDecoration,
            ),
          ),
          Expanded(
            flex: 21,
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    decoration: _cellDecoration,
                    child: Center(
                      child: Text(
                        "Last week",
                        style: headingStyle,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Row(
                    children: List.generate(7, (i) {
                      return Expanded(
                        child: Container(
                          decoration: _cellDecoration,
                          child: Center(
                            child: Text(_weekDates[i]),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    decoration: _cellDecoration,
                    child: Center(
                      child: Text(
                        "Today",
                        style: headingStyle,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: _cellDecoration,
                    child: Center(
                      child: Text(_weekDates[7]),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 7,
            child: Container(
              decoration: _cellDecoration,
              child: Center(
                child: Text(
                  "Habits",
                  style: headingStyle,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

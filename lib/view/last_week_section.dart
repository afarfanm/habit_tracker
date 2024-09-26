import 'package:flutter/material.dart';
import 'package:habit_tracker/model/date_dao.dart';
import 'package:habit_tracker/model/habit.dart';
import 'package:habit_tracker/view/last_week_table.dart';

class LastWeekSection extends StatelessWidget {
  const LastWeekSection({super.key, required List<Habit> habitList})
      : _habitList = habitList;

  final List<Habit> _habitList;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.green),
      ),
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: _getTableHeaders(context),
          ),
          Expanded(
            flex: 9,
            child: SingleChildScrollView(
              child: LastWeekTable(habits: _habitList),
            ),
          )
        ],
      ),
    );
  }

  Row _getTableHeaders(BuildContext context) {
    List<String> weekHeaders = DateDAO.getLastWeekDays();

    return Row(
      children: [
        Expanded(
          flex: 4,
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 0.5)),
            alignment: Alignment.center,
            child: Text("Last week", style: _getHeadingStyle(context)),
          ),
        ),
        ...List.generate(weekHeaders.length, (i) {
          return Expanded(
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 0.5)),
              alignment: Alignment.center,
              child: Text(
                weekHeaders[i],
                textAlign: TextAlign.center,
              ),
            ),
          );
        }),
      ],
    );
  }

  TextStyle? _getHeadingStyle(BuildContext context) {
    return Theme.of(context).textTheme.headlineMedium;
  }
}

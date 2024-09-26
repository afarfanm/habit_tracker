import 'package:flutter/material.dart';
import 'package:habit_tracker/model/date_dao.dart';
import 'package:habit_tracker/model/habit.dart';

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
            child: Row(
              children: _getHeaders(context),
            ),
          ),
          Expanded(
            flex: 9,
            child: SingleChildScrollView(
              child: Table(
                border: TableBorder.all(),
                columnWidths: const <int, TableColumnWidth>{
                  0: FractionColumnWidth(4 / 11),
                  1: FlexColumnWidth(),
                  2: FlexColumnWidth(),
                  3: FlexColumnWidth(),
                  4: FlexColumnWidth(),
                  5: FlexColumnWidth(),
                  6: FlexColumnWidth(),
                  7: FlexColumnWidth(),
                },
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: _generateWeekHistory(),
              ),
            ),
          )
        ],
      ),
    );
  }

  List<Widget> _getHeaders(BuildContext context) {
    List<Widget> headers = [];

    headers.add(Flexible(
      flex: 4,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
        ),
        child: Center(
          child: Text(
            "Last Week",
            style: _getHeadingStyle(context),
          ),
        ),
      ),
    ));

    List<String> dayHeaders = DateDAO.getLastWeekDays();

    for (int i = 0; i < 7; ++i) {
      headers.add(Flexible(
        flex: 1,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
          ),
          child: Center(
            child: Text(
              dayHeaders[i],
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ));
    }

    return headers;
  }

  TextStyle? _getHeadingStyle(BuildContext context) {
    return Theme.of(context).textTheme.headlineMedium;
  }

  List<TableRow> _generateWeekHistory() {
    return List.generate(
      _habitList.length,
      (i) {
        Habit habit = _habitList[i];

        return TableRow(
          children: [
            Container(
              constraints: const BoxConstraints(minHeight: 40),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(habit.name),
              ),
            ),
            ...List.generate(7, (i) {
              return habit.isMarkedAtHistory(i)
                  ? const Icon(Icons.check)
                  : Container();
            }),
          ],
        );
      },
    );
  }
}

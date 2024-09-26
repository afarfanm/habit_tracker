import 'package:flutter/material.dart';
import 'package:habit_tracker/model/habit.dart';

class LastWeekTable extends StatelessWidget {
  const LastWeekTable({super.key, required List<Habit> habits})
      : _habits = habits;

  final List<Habit> _habits;

  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(),
      columnWidths: const <int, TableColumnWidth>{
        0: FractionColumnWidth(4 / 11),
      },
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: List.generate(
        _habits.length,
        (i) {
          Habit habit = _habits[i];

          return TableRow(
            children: [
              Container(
                constraints: const BoxConstraints(minHeight: 40),
                padding: const EdgeInsets.only(left: 8.0),
                color: i % 2 == 0 ? Colors.green[300] : Colors.green[400],
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    habit.name,
                    style: const TextStyle(color: Colors.white),
                  ),
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
      ),
    );
  }
}

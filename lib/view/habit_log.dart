import 'package:flutter/material.dart';
import 'package:habit_tracker/model/habit.dart';

class HabitLog extends StatelessWidget {
  HabitLog(
      {super.key,
      required List<Habit> habits,
      required void Function(bool, int) onMarkToggle,
      required void Function(int) onDelete,
      required void Function(int) onEdit})
      : _onEdit = onEdit,
        _onDelete = onDelete,
        _onMarkToggle = onMarkToggle,
        _habits = habits;

  final List<Habit> _habits;
  final void Function(bool, int) _onMarkToggle;
  final void Function(int) _onDelete;
  final void Function(int) _onEdit;

  final BoxDecoration cellDecoration = BoxDecoration(
    border: Border.all(
      color: Colors.black,
      width: 0.5,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Table(
        defaultColumnWidth: const FractionColumnWidth(3 / 32),
        columnWidths: const <int, TableColumnWidth>{
          0: FractionColumnWidth(1 / 32),
          9: FractionColumnWidth(1 / 32),
          10: FractionColumnWidth(6 / 32),
        },
        border: TableBorder.all(),
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: List.generate(_habits.length, (i) {
          Habit currentHabit = _habits[i];

          return TableRow(
            decoration: BoxDecoration(
              color: i % 2 == 0 ? Colors.green[200] : Colors.green[300],
            ),
            children: [
              IconButton(
                onPressed: () => _onDelete(i),
                icon: const Icon(Icons.delete),
              ),
              ...List.generate(
                7,
                (i) => currentHabit.isMarkedAtHistory(i)
                    ? const Icon(Icons.check)
                    : Container(),
              ),
              Checkbox(
                value: currentHabit.isDoneToday(),
                onChanged: (val) => _onMarkToggle(val!, i),
              ),
              IconButton(
                onPressed: () => _onEdit(i),
                icon: const Icon(Icons.edit),
              ),
              Container(
                constraints: const BoxConstraints(minHeight: 40.0),
                padding: const EdgeInsets.only(left: 8.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(currentHabit.name),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}

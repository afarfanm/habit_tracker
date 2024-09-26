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
        defaultColumnWidth: const FractionColumnWidth(3 / 36),
        columnWidths: const <int, TableColumnWidth>{
          0: FractionColumnWidth(2 / 36),
          9: FractionColumnWidth(2 / 36),
          10: FractionColumnWidth(8 / 36),
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
                    ? const Icon(
                        Icons.check,
                        size: 40.0,
                      )
                    : Container(),
              ),
              Transform.scale(
                scale: 1.8,
                child: Checkbox(
                  value: currentHabit.isDoneToday(),
                  onChanged: (val) => _onMarkToggle(val!, i),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.local_fire_department,
                      size: 50.0,
                      color: Colors.black
                          .withOpacity(currentHabit.isDoneToday() ? 1.0 : 0.2),
                    ),
                    Text(
                      "${currentHabit.streak}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black.withOpacity(
                            currentHabit.isDoneToday() ? 1.0 : 0.2),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () => _onEdit(i),
                      icon: const Icon(Icons.edit),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(currentHabit.name),
                    ),
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}

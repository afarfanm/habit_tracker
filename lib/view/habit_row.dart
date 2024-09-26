import 'package:flutter/material.dart';
import 'package:habit_tracker/model/habit.dart';
import 'package:habit_tracker/model/habits_dao.dart';
import 'package:habit_tracker/view/habit_config_dialog.dart';
import 'package:habit_tracker/view/habit_row_cell.dart';

class HabitRow extends StatefulWidget {
  const HabitRow(
      {super.key,
      required this.habit,
      required this.index,
      required this.onHabitDeletionRequested});

  final Habit habit;
  final int index;
  final void Function(int) onHabitDeletionRequested;

  @override
  State<StatefulWidget> createState() => _HabitRowState();
}

class _HabitRowState extends State<HabitRow> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: HabitRowCell(
            child: IconButton(
              onPressed: () => widget.onHabitDeletionRequested(widget.index),
              icon: const Icon(Icons.delete),
            ),
          ),
        ),
        ...List.generate(
          7,
          (i) {
            return Expanded(
              flex: 3,
              child: HabitRowCell(
                child: Builder(builder: (context) {
                  if (widget.habit.isMarkedNDaysAgo(7 - i)) {
                    return const Icon(
                      Icons.check,
                      size: 40.0,
                    );
                  } else {
                    return Container();
                  }
                }),
              ),
            );
          },
        ),
        Expanded(
          flex: 3,
          child: HabitRowCell(
            child: Transform.scale(
              scale: 1.8,
              child: Checkbox(
                value: widget.habit.isMarkedToday(),
                onChanged: (value) => toggleHabitMarkedToday(),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: HabitRowCell(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.local_fire_department,
                  size: 50.0,
                  color: Colors.black
                      .withOpacity(widget.habit.isMarkedToday() ? 1.0 : 0.2),
                ),
                Text(
                  "${widget.habit.streak}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black
                        .withOpacity(widget.habit.isMarkedToday() ? 1.0 : 0.2),
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 8,
          child: HabitRowCell(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: showHabitEditDialog,
                  icon: const Icon(Icons.edit),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      widget.habit.name,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void toggleHabitMarkedToday() {
    bool toggled = HabitsDAO.toggleHabitMarkedToday(widget.index);
    if (toggled) {
      setState(() {
        widget.habit.toggleMarkedToday();
      });
    }
  }

  void showHabitEditDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return HabitConfigDialog(onHabitSet: (name) {
          String newName = HabitsDAO.renameHabit(widget.index, name);
          setState(() {
            widget.habit.name = newName;
          });
        });
      },
    );
  }
}

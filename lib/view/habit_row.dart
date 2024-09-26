import 'package:flutter/material.dart';
import 'package:habit_tracker/model/habit.dart';
import 'package:habit_tracker/model/habits_dao.dart';
import 'package:habit_tracker/view/habit_config_dialog.dart';
import 'package:habit_tracker/view/habit_row_cell.dart';
import 'package:habit_tracker/view/streak_counter.dart';

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
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme;

    return Container(
      color: widget.index % 2 == 0
          ? colorScheme.surfaceContainer
          : colorScheme.surfaceContainerHigh,
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: HabitRowCell(
              child: IconButton(
                onPressed: () => widget.onHabitDeletionRequested(widget.index),
                icon: Icon(
                  Icons.delete,
                  color: colorScheme.secondary,
                ),
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
                      return Icon(
                        Icons.check,
                        color: colorScheme.tertiary,
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
              child: StreakCounter(
                streakActive: widget.habit.isMarkedToday(),
                streakCount: widget.habit.streak,
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
                    icon: Icon(
                      Icons.edit,
                      color: colorScheme.secondary,
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        widget.habit.name,
                        style: textTheme.bodyLarge!
                            .copyWith(color: colorScheme.tertiary),
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
      ),
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

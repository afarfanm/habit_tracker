import 'package:flutter/material.dart';
import 'package:habit_tracker/model/habit.dart';
import 'package:habit_tracker/model/habits_dao.dart';
import 'package:habit_tracker/view/habit_config_dialog.dart';
import 'package:habit_tracker/view/habit_row_cell.dart';
import 'package:habit_tracker/view/streak_counter.dart';

class HabitRow extends StatefulWidget {
  const HabitRow({
    super.key,
    required this.habitIndex,
  });

  final int habitIndex;

  @override
  State<StatefulWidget> createState() => _HabitRowState();
}

class _HabitRowState extends State<HabitRow> {
  late Habit habit;

  @override
  void initState() {
    super.initState();
    setState(() {
      habit = HabitsDAO.fetchHabit(widget.habitIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme;

    return Container(
      color: widget.habitIndex % 2 == 0
          ? colorScheme.surfaceContainer
          : colorScheme.surfaceContainerHigh,
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: HabitRowCell(
              child: IconButton(
                onPressed: deleteHabit,
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
                    if (habit.isMarkedNDaysAgo(7 - i)) {
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
                  value: habit.isMarkedToday(),
                  onChanged: (value) => toggleHabitMarkedToday(),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: HabitRowCell(
              child: StreakCounter(
                streakActive: habit.isMarkedToday(),
                streakCount: habit.streak,
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
                        habit.name,
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
    HabitsDAO.toggleHabitMarkedToday(widget.habitIndex).then((voidValue) {
      setState(() {
        habit.toggleMarkedToday();
      });
    });
  }

  void showHabitEditDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return HabitConfigDialog(onHabitSet: (name) {
          HabitsDAO.renameHabit(widget.habitIndex, name).then((voidValue) {
            setState(() {
              habit.name = name;
            });
          });
        });
      },
    );
  }

  void deleteHabit() {
    HabitsDAO.deleteHabit(widget.habitIndex);
  }
}

import 'package:flutter/material.dart';
import 'package:habit_tracker/model/habit.dart';
import 'package:habit_tracker/view/habit_row.dart';

class HabitsTableBody extends StatelessWidget {
  const HabitsTableBody({
    super.key,
    required this.habits,
    required this.onHabitDeletionRequested,
  });

  final List<Habit> habits;
  final void Function(int) onHabitDeletionRequested;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: List.generate(
          habits.length,
          (i) {
            return HabitRow(
              habit: habits[i],
              index: i,
              onHabitDeletionRequested: onHabitDeletionRequested,
            );
          },
        ),
      ),
    );
  }
}

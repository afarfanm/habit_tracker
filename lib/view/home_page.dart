import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:habit_tracker/model/habit.dart';
import 'package:habit_tracker/model/habits_dao.dart';
import 'package:habit_tracker/view/habits_table_body.dart';
import 'package:habit_tracker/view/habits_table_header.dart';
import 'package:habit_tracker/view/habit_config_dialog.dart';
import 'package:habit_tracker/view/streak_milestone_dialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final AppLifecycleListener _lifecycleListener;
  final List<Habit> habits = [];

  @override
  void initState() {
    super.initState();
    _lifecycleListener = AppLifecycleListener(
      onExitRequested: () async {
        await HabitsDAO.saveHabits();
        return AppExitResponse.exit;
      },
    );
    HabitsDAO.loadHabits().then((fetchedHabits) {
      setState(() => habits.addAll(fetchedHabits));
    });
    HabitsDAO.onStreakMilestoneAchieved = showHabitStreakMilestoneDialog;
  }

  @override
  void dispose() {
    _lifecycleListener.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: Container(
        margin: const EdgeInsets.all(48.0),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
          ),
        ),
        child: Column(
          children: [
            const Expanded(
              child: HabitsTableHeader(),
            ),
            Expanded(
              flex: 5,
              child: HabitsTableBody(
                habits: habits,
                onHabitDeletionRequested: deleteHabit,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showHabitCreationDialog(),
        tooltip: 'Add habit',
        child: const Icon(Icons.add),
      ),
    );
  }

  void showHabitCreationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return HabitConfigDialog(
          onHabitSet: (name) {
            Habit newHabit = HabitsDAO.createHabit(name);
            setState(() {
              habits.add(newHabit);
            });
          },
        );
      },
    );
  }

  void deleteHabit(int index) {
    bool deleted = HabitsDAO.deleteHabit(index);
    if (deleted) {
      setState(() {
        habits.removeAt(index);
      });
    }
  }

  void showHabitStreakMilestoneDialog(Habit habit) {
    showDialog(
      context: context,
      builder: (buildContext) {
        return StreakMilestoneDialog(habit: habit);
      },
    );
  }
}

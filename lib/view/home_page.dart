import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:habit_tracker/model/alerts_dao.dart';
import 'package:habit_tracker/model/habit.dart';
import 'package:habit_tracker/model/habits_dao.dart';
import 'package:habit_tracker/view/dying_habit_panel.dart';
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
  bool alertsPending = false;

  @override
  void initState() {
    super.initState();
    _lifecycleListener = AppLifecycleListener(
      onExitRequested: () async {
        await HabitsDAO.saveHabits();
        return AppExitResponse.exit;
      },
    );
    HabitsDAO.onStreakMilestoneAchieved = showHabitStreakMilestoneDialog;
    AlertsDAO.onAlertsPendingStateChanged = updateAlertsPendingState;
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
        leading: Builder(
          builder: (context) {
            return IconButton(
              onPressed: () => Scaffold.of(context).openDrawer(),
              icon: Builder(
                builder: (context) {
                  if (alertsPending) {
                    return const Icon(Icons.notification_important);
                  } else {
                    return const Icon(Icons.notification_important_outlined);
                  }
                },
              ),
            );
          },
        ),
      ),
      drawer: const Drawer(
        child: DyingHabitPanel(),
      ),
      body: Container(
        margin: const EdgeInsets.all(48.0),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
          ),
        ),
        child: const Column(
          children: [
            Expanded(
              child: HabitsTableHeader(),
            ),
            Expanded(
              flex: 5,
              child: HabitsTableBody(),
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
            HabitsDAO.createHabit(name);
          },
        );
      },
    );
  }

  void showHabitStreakMilestoneDialog(Habit habit) {
    showDialog(
      context: context,
      builder: (buildContext) {
        return StreakMilestoneDialog(habit: habit);
      },
    );
  }

  void updateAlertsPendingState(bool alertsPending) {
    setState(() {
      this.alertsPending = alertsPending;
    });
  }
}

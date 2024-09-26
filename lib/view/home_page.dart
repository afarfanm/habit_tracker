import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:habit_tracker/model/habit.dart';
import 'package:habit_tracker/model/habits_dao.dart';
import 'package:habit_tracker/view/last_week_section.dart';
import 'package:habit_tracker/view/new_habit_dialog.dart';
import 'package:habit_tracker/view/today_section.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required String title}) : _title = title;

  final String _title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Habit> _habitList = [];
  late final AppLifecycleListener _lifecycleListener;

  @override
  void initState() {
    super.initState();
    HabitsDAO.readHabitRecords().then((fetchedHabits) {
      setState(() {
        for (Habit habit in fetchedHabits) {
          _habitList.add(habit);
        }
      });
    });
    _lifecycleListener = AppLifecycleListener(
      onExitRequested: () async {
        await HabitsDAO.writeHabitRecords(_habitList);
        return AppExitResponse.exit;
      },
    );
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
        title: Text(widget._title),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Flexible(
              flex: 2,
              fit: FlexFit.tight,
              child: LastWeekSection(habitList: _habitList),
            ),
            const SizedBox(width: 16.0),
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: TodaySection(
                habitList: _habitList,
                onHabitMarkToggle: _toggleHabitDoneToday,
                onHabitRemove: _removeHabitAt,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showHabitCreationDialog,
        tooltip: 'Add habit',
        child: const Icon(Icons.add),
      ),
    );
  }

  void _toggleHabitDoneToday(bool marked, int index) {
    setState(() {
      _habitList[index].setDoneToday(marked);
    });
  }

  void _removeHabitAt(int index) {
    setState(() {
      _habitList.removeAt(index);
    });
  }

  void _showHabitCreationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) =>
          NewHabitDialog(onHabitCreated: _addHabit),
    );
  }

  void _addHabit(String name) {
    setState(() {
      _habitList.add(Habit(name));
    });
  }
}

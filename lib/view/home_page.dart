import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:habit_tracker/model/habit.dart';
import 'package:habit_tracker/model/habits_dao.dart';
import 'package:habit_tracker/view/habit_log.dart';
import 'package:habit_tracker/view/header.dart';
import 'package:habit_tracker/view/new_habit_dialog.dart';

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
        margin: const EdgeInsets.all(48.0),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
          ),
        ),
        child: Column(
          children: [
            Header(),
            Expanded(
              flex: 5,
              child: Container(
                color: Colors.grey[400],
                child: HabitLog(),
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

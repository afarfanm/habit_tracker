import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:habit_tracker/model/habit.dart';
import 'package:habit_tracker/model/habits_dao.dart';
import 'package:habit_tracker/view/habit_log.dart';
import 'package:habit_tracker/view/header.dart';
import 'package:habit_tracker/view/habit_name_set_dialog.dart';

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
            Expanded(
              child: Header(),
            ),
            Expanded(
              flex: 5,
              child: HabitLog(
                habits: _habitList,
                onMarkToggle: _toggleHabitDoneToday,
                onDelete: _removeHabitAt,
                onEdit: (index) => _showHabitRenameDialog(context, index),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showHabitCreationDialog(context),
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

  void _showHabitCreationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return HabitNameSetDialog(onHabitNameSet: (name) {
          setState(() {
            _habitList.add(Habit(name));
          });
        });
      },
    );
  }

  void _showHabitRenameDialog(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return HabitNameSetDialog(
          onHabitNameSet: (name) {
            setState(() {
              _habitList[index].name = name;
            });
          },
        );
      },
    );
  }
}

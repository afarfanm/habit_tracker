import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:habit_tracker/model/habit.dart';
import 'package:habit_tracker/model/habits_dao.dart';
import 'package:habit_tracker/view/new_habit_dialog.dart';
import 'package:habit_tracker/view/today_list_item.dart';

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
      body: Center(
        child: Column(
          children: [
            Text("Today", style: _getHeadlineStyle(context)),
            const SizedBox(height: 16.0),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: _generateHabitList(),
                ),
              ),
            ),
            const SizedBox(height: 100),
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

  TextStyle? _getHeadlineStyle(BuildContext context) {
    return Theme.of(context).textTheme.headlineMedium;
  }

  List<Widget> _generateHabitList() {
    return List.generate(
      _habitList.length,
      (i) {
        return Container(
          color: i % 2 == 0 ? Colors.green[500] : Colors.green[400],
          child: TodayListItem(
            habit: _habitList[i],
            onMarkToggle: (m) => _toggleHabitDoneMark(m, i),
            onDelete: () => _removeHabitAt(i),
          ),
        );
      },
    );
  }

  void _toggleHabitDoneMark(bool marked, int index) {
    setState(() {
      _habitList[index].done = marked;
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

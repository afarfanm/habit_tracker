import 'package:flutter/material.dart';
import 'package:habit_tracker/model/habit.dart';
import 'package:habit_tracker/view/today_list_item.dart';

class TodaySection extends StatelessWidget {
  const TodaySection(
      {super.key,
      required List<Habit> habitList,
      required void Function(bool, int) onHabitMarkToggle,
      required void Function(int) onHabitRemove})
      : _onHabitRemove = onHabitRemove,
        _onHabitMarkToggle = onHabitMarkToggle,
        _habitList = habitList;

  final List<Habit> _habitList;
  final void Function(bool, int) _onHabitMarkToggle;
  final void Function(int) _onHabitRemove;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.green),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Text("Today", style: _getHeadlineStyle(context)),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: _generateHabitList(),
              ),
            ),
          ),
        ],
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
            onMarkToggle: (m) => _onHabitMarkToggle(m, i),
            onDelete: () => _onHabitRemove(i),
          ),
        );
      },
    );
  }
}

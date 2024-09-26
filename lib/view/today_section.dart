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
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: Container(
              padding: EdgeInsets.all(8.0),
              child: Text("Today", style: _getHeadlineStyle(context)),
            ),
          ),
          Flexible(
            flex: 9,
            fit: FlexFit.tight,
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
          constraints: const BoxConstraints(minHeight: 40.0),
          color: i % 2 == 0 ? Colors.green[300] : Colors.green[400],
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

import 'package:flutter/material.dart';
import 'package:habit_tracker/model/habit.dart';

class TodayListItem extends StatelessWidget {
  const TodayListItem(
      {super.key,
      required Habit habit,
      required void Function(bool) onMarkToggle,
      required void Function() onDelete})
      : _onDelete = onDelete,
        _onMarkToggle = onMarkToggle,
        _habit = habit;

  final Habit _habit;
  final void Function(bool) _onMarkToggle;
  final void Function() _onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Checkbox(
            value: _habit.done,
            tristate: false,
            onChanged: (marked) => _onMarkToggle(marked!),
            side: _getCheckboxBorderSide(),
            activeColor: Colors.transparent,
            checkColor: Colors.white,
          ),
          SizedBox(
            width: 300.0,
            child: Text(
              _habit.name,
              style: const TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(width: 8.0),
          IconButton(
            onPressed: _onDelete,
            icon: const Icon(Icons.delete, color: Colors.white),
          ),
        ],
      ),
    );
  }

  WidgetStateBorderSide _getCheckboxBorderSide() {
    return WidgetStateBorderSide.resolveWith((states) {
      return const BorderSide(
        color: Colors.white,
        width: 2.0,
      );
    });
  }
}

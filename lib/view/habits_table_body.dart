import 'package:flutter/material.dart';
import 'package:habit_tracker/model/habits_dao.dart';
import 'package:habit_tracker/view/habit_row.dart';

class HabitsTableBody extends StatefulWidget {
  const HabitsTableBody({super.key});

  @override
  State<StatefulWidget> createState() => _HabitsTableBodyState();
}

class _HabitsTableBodyState extends State<HabitsTableBody> {
  int habitListLength = 0;

  @override
  void initState() {
    super.initState();
    HabitsDAO.onHabitListChanged = (newLength) {
      setState(() {
        habitListLength = newLength;
      });
    };
    HabitsDAO.init();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: List.generate(
          habitListLength,
          (i) {
            return HabitRow(
              key: UniqueKey(),
              habitIndex: i,
            );
          },
        ),
      ),
    );
  }
}

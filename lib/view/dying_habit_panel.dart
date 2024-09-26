import 'package:flutter/material.dart';
import 'package:habit_tracker/view/dying_habit_alert.dart';

class DyingHabitPanel extends StatelessWidget {
  const DyingHabitPanel({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        Expanded(
          child: Center(
            child: Text(
              "Dying habit alerts",
              style: textTheme.headlineSmall,
            ),
          ),
        ),
        Expanded(
          flex: 9,
          child: ListView(
            children: List.generate(
              5,
              (i) {
                return DyingHabitAlert();
              },
            ),
          ),
        ),
      ],
    );
  }
}

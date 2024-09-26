import 'package:flutter/material.dart';
import 'package:habit_tracker/model/habit.dart';

class StreakMilestoneDialog extends StatelessWidget {
  StreakMilestoneDialog({super.key, required this.habit}) {
    int streak = habit.streak;

    if (streak < 21) {
      _milestoneFeedback = "Go for another week!";
    } else if (streak == 21) {
      _milestoneFeedback = "Keep it up to 25 days!";
    } else {
      _milestoneFeedback = "Keep going to reach ${streak + 25} days!";
    }
  }

  final Habit habit;
  late final String _milestoneFeedback;

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return AlertDialog(
      title: const Text(
        "Milestone achieved!",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RichText(
            text: TextSpan(
              text: "You reached ",
              style: TextStyle(color: colorScheme.onSurface),
              children: [
                TextSpan(
                  text: "${habit.streak} days",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const TextSpan(
                  text: " of your habit",
                ),
              ],
            ),
          ),
          Text(
            habit.name,
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(_milestoneFeedback),
        ],
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text("Let's go!"),
        ),
      ],
    );
  }
}

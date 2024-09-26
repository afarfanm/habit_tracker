import 'package:flutter/material.dart';
import 'package:habit_tracker/model/alert.dart';

class DyingHabitAlert extends StatelessWidget {
  DyingHabitAlert({super.key, required this.alert}) {
    int daysInterrupted = alert.daysInterrupted;

    if (daysInterrupted < 14) {
      _feedbackMessage = "go back to it and start a new streak!";
    } else if (daysInterrupted < 21) {
      _feedbackMessage = "don't give up on it and start a new streak!";
    } else {
      _feedbackMessage = "give it another chance and start a new streak!";
    }
  }

  final Alert alert;
  late final String _feedbackMessage;

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        color: colorScheme.secondaryContainer,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: RichText(
              text: TextSpan(
                text: "Your habit ",
                style: TextStyle(color: colorScheme.onSecondaryContainer),
                children: [
                  TextSpan(
                    text: alert.habitName,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const TextSpan(
                    text: " hasn't been marked for ",
                  ),
                  TextSpan(
                    text: "${alert.daysInterrupted} days",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: ", $_feedbackMessage",
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

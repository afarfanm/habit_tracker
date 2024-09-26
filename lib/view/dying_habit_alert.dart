import 'package:flutter/material.dart';

class DyingHabitAlert extends StatelessWidget {
  const DyingHabitAlert({super.key});

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
                children: const [
                  TextSpan(
                    text: "[Habit Name]",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: " hasn't been marked for ",
                  ),
                  TextSpan(
                    text: "[N days]",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: ", resume it and start a streak!",
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 8.0),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: () => print("Alert button pressed"),
              child: const Text("Got it!"),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class StreakCounter extends StatelessWidget {
  const StreakCounter({
    super.key,
    required this.streakActive,
    required this.streakCount,
  });

  final bool streakActive;
  final int streakCount;

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    Color activeColor = colorScheme.primary;
    Color inactiveColor = colorScheme.primary.withAlpha(0xCC);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 4.0),
        Icon(
          streakActive
              ? Icons.local_fire_department
              : Icons.local_fire_department_outlined,
          size: 50.0,
          color: streakActive ? activeColor : inactiveColor,
        ),
        Text(
          "$streakCount",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: streakActive ? activeColor : inactiveColor),
        ),
        const SizedBox(height: 4.0),
      ],
    );
  }
}

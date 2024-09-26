import 'package:flutter/material.dart';

class HabitRowCell extends StatelessWidget {
  const HabitRowCell({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 0.5,
        ),
      ),
      constraints: const BoxConstraints(minHeight: 80.0),
      child: child,
    );
  }
}

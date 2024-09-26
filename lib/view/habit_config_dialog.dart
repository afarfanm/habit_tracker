import 'package:flutter/material.dart';

class HabitConfigDialog extends StatefulWidget {
  const HabitConfigDialog({super.key, required this.onHabitSet});

  final void Function(String) onHabitSet;

  @override
  State<HabitConfigDialog> createState() => _HabitConfigDialogState();
}

class _HabitConfigDialogState extends State<HabitConfigDialog> {
  late final TextEditingController _newHabitTextInputController;
  String _errorMessage = "";

  @override
  void initState() {
    super.initState();
    _newHabitTextInputController = TextEditingController();
  }

  @override
  void dispose() {
    _newHabitTextInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Habit name"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _newHabitTextInputController,
            autofocus: true,
            maxLength: 75,
          ),
          const SizedBox(height: 16.0),
          Builder(builder: _renderOptionalErrorMessage),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => _cancelHabitCreation(context),
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: () => _confirmHabitCreation(context),
          child: const Text("Set"),
        ),
      ],
    );
  }

  Widget _renderOptionalErrorMessage(BuildContext context) {
    if (_errorMessage.isNotEmpty) {
      return Text(
        _errorMessage,
        style: const TextStyle(color: Colors.red),
      );
    } else {
      return Container();
    }
  }

  void _cancelHabitCreation(BuildContext context) {
    _errorMessage = "";
    Navigator.of(context).pop();
  }

  void _confirmHabitCreation(BuildContext context) {
    String newHabitName = _newHabitTextInputController.text;

    if (newHabitName.isEmpty) {
      setState(() {
        _errorMessage = "Enter a name for the new habit";
      });
    } else {
      _errorMessage = "";
      widget.onHabitSet(newHabitName);
      Navigator.of(context).pop();
    }
  }
}

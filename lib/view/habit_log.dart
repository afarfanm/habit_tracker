import 'package:flutter/material.dart';

class HabitLog extends StatefulWidget {
  const HabitLog({super.key});

  @override
  State<HabitLog> createState() => _HabitLogState();
}

class _HabitLogState extends State<HabitLog> {
  BoxDecoration cellDecoration = BoxDecoration(
    border: Border.all(
      color: Colors.black,
      width: 0.5,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Table(
      defaultColumnWidth: FractionColumnWidth(3 / 32),
      columnWidths: <int, TableColumnWidth>{
        0: FractionColumnWidth(1 / 32),
        9: FractionColumnWidth(1 / 32),
        10: FractionColumnWidth(6 / 32),
      },
      border: TableBorder.all(),
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: [
        TableRow(
          children: [
            IconButton(
              onPressed: () => print("pressed"),
              icon: Icon(Icons.delete),
            ),
            ...List.generate(
              7,
              (i) => Icon(Icons.check),
            ),
            Checkbox(value: false, onChanged: (val) => print("toggled")),
            IconButton(
              onPressed: () => print("pressed"),
              icon: Icon(Icons.edit),
            ),
            Container(
              constraints: BoxConstraints(minHeight: 40.0),
              padding: EdgeInsets.only(left: 8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text("Some habit 1"),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

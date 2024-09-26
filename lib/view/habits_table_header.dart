import 'package:flutter/material.dart';
import 'package:habit_tracker/model/date_dao.dart';

class HabitsTableHeader extends StatelessWidget {
  const HabitsTableHeader({super.key});

  BoxDecoration get _cellDecoration {
    return BoxDecoration(
      border: Border.all(
        color: Colors.black,
        width: 0.5,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<String> weekDates = DateDAO.getLastWeekDays();
    TextStyle? headingStyle = Theme.of(context).textTheme.displaySmall;

    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Container(
            decoration: _cellDecoration,
          ),
        ),
        Expanded(
          flex: 21,
          child: Column(
            children: [
              Expanded(
                child: Container(
                  decoration: _cellDecoration,
                  child: Center(
                    child: Text(
                      "Last week",
                      style: headingStyle,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Row(
                  children: List.generate(7, (i) {
                    return Expanded(
                      child: Container(
                        decoration: _cellDecoration,
                        child: Center(
                          child: Text(weekDates[i]),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 3,
          child: Column(
            children: [
              Expanded(
                child: Container(
                  decoration: _cellDecoration,
                  child: Center(
                    child: Text(
                      "Today",
                      style: headingStyle,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  decoration: _cellDecoration,
                  child: Center(
                    child: Text(weekDates[7]),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 10,
          child: Container(
            decoration: _cellDecoration,
            child: Center(
              child: Text(
                "Habits",
                style: headingStyle,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

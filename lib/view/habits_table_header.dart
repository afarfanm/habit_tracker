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
    TextTheme textTheme = Theme.of(context).textTheme;

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
                      style: textTheme.displaySmall,
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
                          child: Text(
                            weekDates[i],
                            style: textTheme.bodyLarge,
                          ),
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
                      style: textTheme.displaySmall,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  decoration: _cellDecoration,
                  child: Center(
                    child: Text(
                      weekDates[7],
                      style: textTheme.bodyLarge,
                    ),
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
                style: textTheme.displaySmall,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

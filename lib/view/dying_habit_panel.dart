import 'package:flutter/material.dart';
import 'package:habit_tracker/model/alerts_dao.dart';
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
          child: Builder(
            builder: (context) {
              int numberOfAlerts = AlertsDAO.numberOfAlerts();

              if (numberOfAlerts == 0) {
                return const Text("There are no alerts");
              } else {
                return ListView(
                  children: List.generate(
                    numberOfAlerts,
                    (i) {
                      return DyingHabitAlert(alert: AlertsDAO.fetchAlert(i));
                    },
                  ),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChartBarWidget extends StatelessWidget {
  final String day;
  final double expenseAmount;
  final double expensePrecentange;

  const ChartBarWidget(
      {Key? key,
      required this.day,
      required this.expenseAmount,
      required this.expensePrecentange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 20,
          child: FittedBox(
            child: Text(NumberFormat.compactSimpleCurrency(
                    locale: 'id', decimalDigits: 0)
                .format(expenseAmount)),
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        SizedBox(
          height: 60,
          width: 10,
          child: Stack(children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey, width: 1.0),
                  color: const Color.fromRGBO(220, 229, 200, 1)),
            ),
            FractionallySizedBox(
              heightFactor: expensePrecentange,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).primaryColor),
              ),
            )
          ]),
        ),
        const SizedBox(
          height: 4,
        ),
        Text(day)
      ],
    );
  }
}

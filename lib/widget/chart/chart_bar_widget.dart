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
    return LayoutBuilder(builder: (ctx, constraints) {
      return Column(
        children: [
          SizedBox(
            height: constraints.maxHeight * 0.15,
            child: FittedBox(
              child: Text(NumberFormat.compactSimpleCurrency(
                      locale: 'id', decimalDigits: 0)
                  .format(expenseAmount)),
            ),
          ),
          SizedBox(
            height: constraints.maxHeight * 0.05,
          ),
          SizedBox(
            height: constraints.maxHeight * 0.6,
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
          SizedBox(
            height: constraints.maxHeight * 0.05,
          ),
          SizedBox(
              height: constraints.maxHeight * 0.15,
              child: FittedBox(child: Text(day)))
        ],
      );
    });
  }
}

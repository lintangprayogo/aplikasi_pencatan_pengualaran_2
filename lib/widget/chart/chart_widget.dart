import 'package:aplikasi_pencatan_pengualaran/model/expense.dart';
import 'package:aplikasi_pencatan_pengualaran/widget/chart/chart_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Expense> recentExpense;

  const Chart({Key? key, required this.recentExpense}) : super(key: key);

  List<Map<String, Object>> get groupTransaction {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double amount = 0.0;
      for (var i = 0; i < recentExpense.length; i++) {
        if (recentExpense[i].date.day == weekDay.day &&
            recentExpense[i].date.year == weekDay.year &&
            recentExpense[i].date.month == recentExpense[i].date.month) {
          amount += recentExpense[i].nominal;
        }
      }
      return {
        'day': DateFormat.E("in_ID").format(weekDay).substring(0, 1),
        'amount': amount
      };
    }).reversed.toList();
  }

  double get totalExpense {
    return groupTransaction.fold(0.0, (sum, data) {
      if (data['amount'] != null) {
        return sum + (data['amount']! as double);
      } else {
        return sum;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(20),
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupTransaction.map((data) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBarWidget(
                  day: data['day'] as String,
                  expenseAmount: data['amount'] as double,
                  expensePrecentange: totalExpense == 0.0
                      ? 0.0
                      : (data['amount'] as double) / totalExpense),
            );
          }).toList(),
        ),
      ),
    );
  }
}

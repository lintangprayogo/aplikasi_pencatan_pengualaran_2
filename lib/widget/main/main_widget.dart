import 'package:aplikasi_pencatan_pengualaran/model/expense.dart';
import 'package:aplikasi_pencatan_pengualaran/widget/chart/chart_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MainWidget extends StatelessWidget {
  final List<Expense> expenses;
  final void Function(int pos) deleteItem;
  final double appBarHeight;

  const MainWidget(
      {Key? key,
      required this.expenses,
      required this.deleteItem,
      required this.appBarHeight})
      : super(key: key);

  List<Expense> get recentExpense {
    return expenses
        .where((element) =>
            element.date.isAfter(DateTime.now().subtract(Duration(days: 7))))
        .toList();
  }

  @override
  Widget build(BuildContext ctx) {
    return Column(
      children: [
        SizedBox(
            height: (MediaQuery.of(ctx).size.height -
                    appBarHeight -
                    MediaQuery.of(ctx).padding.top) *
                0.3,
            child: Chart(recentExpense: recentExpense)),
        SizedBox(
          height: (MediaQuery.of(ctx).size.height -
                  appBarHeight -
                  MediaQuery.of(ctx).padding.top) *
              0.7,
          child: expenses.isEmpty
              ? Column(
                  children: [
                    Text("No expenses have been added yet"),
                    SizedBox(
                      height: 200,
                      child: Image.asset(
                        "assets/images/waiting.png",
                        fit: BoxFit.cover,
                      ),
                    )
                  ],
                )
              : ListView.builder(
                  itemCount: expenses.length,
                  itemBuilder: (context, index) {
                    // return ExpenseCardWidget(expense: _expenses[index]);
                    return Card(
                      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                      child: ListTile(
                        //widget that start from Begining
                        leading: CircleAvatar(
                          radius: 30,
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: FittedBox(
                              child: Text(NumberFormat.compactCurrency(
                                      locale: "id", decimalDigits: 0)
                                  .format(expenses[index].nominal)),
                            ),
                          ),
                        ),
                        title: Text(
                          expenses[index].title,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        subtitle: Text(
                          DateFormat("dd/MM/yyyy").format(expenses[index].date),
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            deleteItem(index);
                          },
                          icon: Icon(Icons.delete),
                          color: Colors.red,
                        ),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}

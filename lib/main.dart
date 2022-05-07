// ignore_for_file: prefer_const_constructors

import 'package:aplikasi_pencatan_pengualaran/widget/chart/chart_widget.dart';
import 'package:aplikasi_pencatan_pengualaran/widget/custom_card/expense_card_widget.dart';
import 'package:aplikasi_pencatan_pengualaran/widget/input/input_expense_widget.dart';
import 'package:flutter/material.dart';
import 'package:aplikasi_pencatan_pengualaran/model/expense.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final List<Expense> _expenses = [];

  List<Expense> get recentExpense {
    return _expenses
        .where((element) =>
            element.date.isAfter(DateTime.now().subtract(Duration(days: 7))))
        .toList();
  }

  void _saveExpense(String title, int nominal, DateTime dateTime) {
    Expense newExpense = Expense(
        id: DateTime.now().toString(),
        title: title,
        nominal: nominal,
        date: dateTime);
    setState(() {
      _expenses.add(newExpense);
    });
  }

  void _showExpenseForm(BuildContext ctx) => showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
            onTap: () {},
            behavior: HitTestBehavior.opaque,
            child: InputExpenseWidget(
              savePressed: _saveExpense,
            ));
      });

  void deleteItem(int index) {
    setState(() {
      _expenses.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting(); //Initialisasi Tanggal

    return MaterialApp(
      theme: ThemeData(
          primarySwatch: Colors.red,
          fontFamily: 'Quicksand',
          appBarTheme: AppBarTheme(
              textTheme: ThemeData.light().textTheme.copyWith(
                  titleMedium:
                      TextStyle(fontFamily: "OpenSans", fontSize: 30)))),
      home: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: Text(
            "Pencatatan Pengeluaran",
            // style: TextStyle(fontFamily: "OpenSans"),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  BuildContext? curentContext = scaffoldKey.currentContext;
                  if (curentContext != null) {
                    _showExpenseForm(curentContext);
                  }
                },
                icon: Icon(
                  Icons.add,
                  color: Colors.white,
                ))
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Chart(recentExpense: recentExpense),
              SizedBox(
                height: 300,
                child: _expenses.isEmpty
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
                        itemCount: _expenses.length,
                        itemBuilder: (context, index) {
                          // return ExpenseCardWidget(expense: _expenses[index]);
                          return Card(
                            margin: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 5),
                            child: ListTile(
                              //widget that start from Begining
                              leading: CircleAvatar(
                                radius: 30,
                                child: Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: FittedBox(
                                    child: Text(NumberFormat.compactCurrency(
                                            locale: "id", decimalDigits: 0)
                                        .format(_expenses[index].nominal)),
                                  ),
                                ),
                              ),
                              title: Text(
                                _expenses[index].title,
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              subtitle: Text(
                                DateFormat("dd/MM/yyyy")
                                    .format(_expenses[index].date),
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
          ),
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              BuildContext? curentContext = scaffoldKey.currentContext;
              if (curentContext != null) {
                _showExpenseForm(curentContext);
              }
            },
            child: Icon(Icons.add)),
      ),
    );
  }
}

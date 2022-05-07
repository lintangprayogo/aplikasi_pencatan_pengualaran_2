// ignore_for_file: prefer_const_constructors

import 'package:aplikasi_pencatan_pengualaran/widget/chart/chart_widget.dart';
import 'package:aplikasi_pencatan_pengualaran/widget/input/input_expense_widget.dart';
import 'package:aplikasi_pencatan_pengualaran/widget/main/main_widget.dart';
import 'package:flutter/material.dart';
import 'package:aplikasi_pencatan_pengualaran/model/expense.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

void main() {
  //setting to orientation
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
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
  Widget build(BuildContext ctx) {
    initializeDateFormatting(); //Initialisasi Tanggal

    AppBar appBar = AppBar(
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
    );

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
        appBar: appBar,
        body: SingleChildScrollView(
            child: MainWidget(
          expenses: _expenses,
          deleteItem: deleteItem,
          appBarHeight: appBar.preferredSize.height,
        )),
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

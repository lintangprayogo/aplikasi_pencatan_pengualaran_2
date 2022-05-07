// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

//use state use widget biar tidak berubah
class InputExpenseWidget extends StatefulWidget {
  final void Function(String title, int nominal, DateTime selectDate)
      savePressed;

  const InputExpenseWidget({Key? key, required this.savePressed})
      : super(key: key);

  @override
  State<InputExpenseWidget> createState() => _InputExpenseWidgetState();
}

class _InputExpenseWidgetState extends State<InputExpenseWidget> {
  final titleController = TextEditingController();
  final nominalController = TextEditingController();
  DateTime? selectDate;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              textAlign: TextAlign.start,
              decoration: const InputDecoration(labelText: "Judul"),
              controller: titleController,
            ),
            TextField(
              textAlign: TextAlign.start,
              decoration: const InputDecoration(labelText: "Nominal"),
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              controller: nominalController,
            ),
            SizedBox(
              height: 70,
              child: Row(
                children: [
                  Text("Tidak Ada Tanggal Diplih !"),
                  TextButton(
                      onPressed: () {
                        _showDate(context);
                      },
                      child: Text(
                        selectDate == null
                            ? "Pilih Tanggal"
                            : DateFormat("dd/MM/yyyy").format(selectDate!),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor),
                      ))
                ],
              ),
            ),
            ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Theme.of(context).primaryColor)),
                onPressed: () {
                  if (nominalController.text.isNotEmpty && selectDate != null) {
                    int? nominal = int.tryParse(nominalController.text);
                    //accesing valu from oin state
                    widget.savePressed(
                        titleController.text, nominal ?? 0, selectDate!);
                    Navigator.of(context).pop();
                  }
                },
                child: Text(
                  "Simpan Penggeluaran",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ))
          ],
        ),
      ),
    );
  }

  void _showDate(BuildContext ctx) {
    showDatePicker(
            context: ctx,
            initialDate: DateTime.now(),
            firstDate: DateTime(2022),
            lastDate: DateTime.now())
        .then((value) => {
              if (value != null)
                {
                  setState(() {
                    selectDate = value;
                  })
                }
            });
  }
}

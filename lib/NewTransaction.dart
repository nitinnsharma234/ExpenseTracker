import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  const NewTransaction(this.addTx, {super.key});

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final tittleController = TextEditingController();
  var _selectedDate ;
  final amountController = TextEditingController();

  void launchDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime(2023),
            firstDate: DateTime(2015),
            lastDate: DateTime.now())
        .then((value) {
          if (value==null)
            {
              return ;
            }
          else{
                setState(() {
                    _selectedDate=value;
                });
          }
    });
  }

  void submitData() {
    final enteredTitle = tittleController.text;
    final enteredAmount = double.parse(amountController.text);
    final dateSelected=_selectedDate;
    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate==null) {
      return;
    }
    print(enteredTitle);
    print(enteredAmount);
    widget.addTx(enteredTitle, enteredAmount,dateSelected);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(label: Text("Title")),
              controller: tittleController,
              onSubmitted: (_) => {submitData()},
            ),
            TextField(
              decoration: const InputDecoration(label: Text("Amount")),
              controller: amountController,
              onSubmitted: (_) => {submitData()},
              keyboardType: TextInputType.number,
            ),
            Row(
              children: [
                 Expanded(
                   child: Text(
                      _selectedDate==null?"No date is chosen!":DateFormat.yMd().format(_selectedDate)),
                 ),
               
                TextButton(
                    onPressed: () {
                      //DatePicker.showDatePicker(context);
                      launchDatePicker();
                    },
                    child: const Text(
                      "Choose Date",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ))
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                submitData();
                print(amountController.text);
              },
              child: const Text(
                "Add Transaction",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

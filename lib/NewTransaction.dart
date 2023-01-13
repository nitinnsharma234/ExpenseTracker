import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  const NewTransaction(this.addTx, {super.key});

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final tittleController = TextEditingController();

  final amountController = TextEditingController();

  void  submitData(){
    final enteredTitle=tittleController.text;
    final enteredAmount=double.parse(amountController.text);

    if (enteredTitle.isEmpty ||  enteredAmount <=0) {
      return;
    }
    print(enteredTitle);
    print(enteredAmount);
      widget.addTx(enteredTitle,enteredAmount);
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
              controller: tittleController,onSubmitted: (_)=>{
                submitData()
            },),
            TextField(decoration: const InputDecoration(label: Text("Amount")),
              controller: amountController,onSubmitted: (_)=>{
                  submitData()
              },keyboardType: TextInputType.number,),
            TextButton(onPressed:(){
                submitData();

                print(amountController.text);
            },
              child: const Text("Add Transaction", style: TextStyle(color:
              Colors.purple),),
            ),
          ],
        ),
      ),
    );
  }
}

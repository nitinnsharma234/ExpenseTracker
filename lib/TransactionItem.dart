import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'Model /Transaction.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    Key? key,
    required this.userTransaction,
    required this.removeTransaction,
  }) : super(key: key);

  final Transaction userTransaction;
  final Function removeTransaction;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      child: ListTile(
        leading: FittedBox(
          child: CircleAvatar(
            radius: 30,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '\$${userTransaction.amount}',
                style: const TextStyle(fontSize: 14),
              ),
            ),
          ),
        ),
        title: Text(userTransaction.title),
        subtitle: Text(
            DateFormat.yMMMd().format(userTransaction.date)),
        trailing: MediaQuery.of(context).size.width > 400
            ? TextButton.icon(
          icon: const Icon(Icons.delete, color: Colors.red,),
          onPressed: () {
            removeTransaction(userTransaction.id);
          },
          label: const Text(
            "Delete",
            style: TextStyle(color: Colors.red),
          ),
        )
            : IconButton(
          onPressed: () {
            removeTransaction(userTransaction.id);
          },
          icon: const Icon(
            Icons.delete,
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
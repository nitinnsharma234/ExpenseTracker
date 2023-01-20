import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'Model /Transaction.dart';
import 'TransactionItem.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> userTransaction;
  final Function removeTransaction;

  const TransactionList(this.userTransaction, this.removeTransaction,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return userTransaction.isNotEmpty
        ? ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return /*Card(
         child: Row(
           children: [
             Container(
               margin: const EdgeInsets.symmetric(
                   vertical: 10, horizontal: 15),
               decoration: BoxDecoration(
                   border: Border.all(color: Colors.purple, width: 2)),
               padding: const EdgeInsets.all(10),
               child: Text(
                 "\$${userTransaction[index].amount.toStringAsFixed(2)}",
                 style: const TextStyle(
                     fontWeight: FontWeight.bold,
                     fontSize: 15,
                     color: Colors.purple),
               ),
             ),
             Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Text(
                   userTransaction[index].title,
                   style: const TextStyle(
                       fontSize: 16, fontWeight: FontWeight.bold),
                 ),
                 Text(DateFormat.yMMMd().format(userTransaction[index].date),
                     style: const TextStyle(color: Colors.grey))
               ],
             )
           ],
         ),
           )*/
                  TransactionItem(userTransaction: userTransaction[index], removeTransaction: removeTransaction);
            },
            itemCount: userTransaction.length,
          )
        : LayoutBuilder(builder: (ctx, constraints) {
            return Column(
              children: [
                Text("No Transactions Added!!"),
                SizedBox(height: constraints.maxHeight * 0.1),
                Container(
                  height: MediaQuery.of(context).orientation==Orientation.landscape?constraints.maxHeight * 0.8:constraints.maxHeight * 0.3,
                  child: Image.asset(
                    "assests/images/notFound.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            );
          });
  }
}



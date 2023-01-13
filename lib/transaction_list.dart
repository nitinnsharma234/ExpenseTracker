import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'Model /Transaction.dart';

class TransactionList extends StatefulWidget {
  final List<Transaction> userTransaction;

  const TransactionList(this.userTransaction, {Key? key}) : super(key: key);

  @override
  State<TransactionList> createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  void removeTransaction(int index)
  {
    setState(() {
      widget.userTransaction.removeAt(index);
    });
  }
  @override
  Widget build(BuildContext context) {
    return widget.userTransaction.isNotEmpty
        ? Container(
            height: 500,
            child: ListView.builder(
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
                    Card(
                  elevation: 5,
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  child: ListTile(
                    leading: FittedBox(
                      child: CircleAvatar(
                        radius: 30,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            '\$${widget.userTransaction[index].amount}',
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                      ),
                    ),
                    title: Text('${widget.userTransaction[index].title}'),
                    subtitle: Text(
                        DateFormat.yMMMd().format(widget.userTransaction[index].date)),
                    trailing: IconButton(
                      onPressed: () {
                        removeTransaction(index);
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    ),
                  ),
                );
              },
              itemCount: widget.userTransaction.length,
            ),
          )
        : Column(
            children: [
              Image.asset(
                "assests/images/notFound.png",
                fit: BoxFit.cover,
              ),
            ],
          );
  }
}

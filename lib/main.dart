import 'package:expense_tracker/Model%20/Transaction.dart';
import 'package:expense_tracker/transaction_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'NewTransaction.dart';
import 'chart.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // setting up the device as always in a portrait mode
  //SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter App ",
      home: const MyHomePage(),
      theme: ThemeData(
          // Define the default brightness and colors.
          brightness: Brightness.light,
          primarySwatch: Colors.purple,
          accentColor: Colors.green,
          primaryColor: Colors.pinkAccent[800],
          appBarTheme: const AppBarTheme(
              titleTextStyle: TextStyle(
                  fontFamily: 'OpenSans', fontStyle: FontStyle.italic))

          // Define the default `TextTheme`. Use this to specify the default
          // text styling for headlines, titles, bodies of text, and more.
          /*textTheme: const TextTheme(
          headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        ),*/
          ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransaction = [
    Transaction(id: "1", title: "Shoes", amount: 400.00, date: DateTime.now()),
    Transaction(
        id: "2", title: "New Phone", amount: 600.00, date: DateTime.now()),
    Transaction(id: "3", title: "Tablet", amount: 170.00, date: DateTime.now())
  ];

  List<Transaction> get _recentTransactions {
    return _userTransaction.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(const Duration(days: 7)));
    }).toList();
  }

  void _addNewTransaction(String txTitle, double txAmount,DateTime date) {
    final newTrx = Transaction(
        id: DateTime.now().toString(),
        title: txTitle,
        amount: txAmount,
        date: date);
    setState(() {
      _userTransaction.add(newTrx);
    });
  }
  void removeTransaction(int index)
  {
    setState(() {
      _userTransaction.removeAt(index);
    });
  }

  void startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (context) {
          return NewTransaction(_addNewTransaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    final appbar = AppBar(
      title: const Text("Expense Tracker",
          style: TextStyle(
              fontFamily: 'OpenSans', fontWeight: FontWeight.bold)),
      actions: [
        IconButton(
            onPressed: () => startAddNewTransaction(context),
            icon: const Icon(
              Icons.add,

            ))
      ],
    );
    return Scaffold(
      appBar:appbar,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const Card(
              color: Colors.blue,
              elevation: 5,
              child: Text("Chart!"),
            ),
             Container(height: (MediaQuery.of(context).size.height-MediaQuery.of(context).padding.top-MediaQuery.of(context).padding.bottom-appbar.preferredSize.height)*0.3,child: Chart(_recentTransactions)),
            Container(height: (MediaQuery.of(context).size.height-MediaQuery.of(context).padding.top-MediaQuery.of(context).padding.bottom-appbar.preferredSize.height)*0.7,child: TransactionList(_userTransaction,removeTransaction))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => startAddNewTransaction(context),
        child: Icon(Icons.add),
      ),
    );
  }
}

import 'dart:io';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:flutter/cupertino.dart';
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
    return
      MaterialApp(
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
  bool _showChart = true;

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

  void _addNewTransaction(String txTitle, double txAmount, DateTime date) {
    final newTrx = Transaction(
        id: DateTime.now().toString(),
        title: txTitle,
        amount: txAmount,
        date: date);
    setState(() {
      _userTransaction.add(newTrx);
    });
  }

  void removeTransaction(String id) {
    setState(() {
      _userTransaction.removeWhere((element) => element.id==id);
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
    final isLandscape = MediaQuery
        .of(context)
        .orientation == Orientation.landscape;

    final  dynamic appbar = Platform.isIOS ? CupertinoNavigationBar(
      middle: const Text("Expense Tracker",
        style: TextStyle(
            fontFamily: 'OpenSans', fontWeight: FontWeight.bold),
      ),
      trailing: Row(mainAxisSize:MainAxisSize.min,children: [GestureDetector(
        child: const Icon(CupertinoIcons.add), onTap: () {
        startAddNewTransaction(context);
      },),
      ],),
    ) : AppBar(
      title: const Text("Expense Tracker",
          style:
          TextStyle(fontFamily: 'OpenSans', fontWeight: FontWeight.bold)),
      actions: [
        IconButton(
            onPressed: () => startAddNewTransaction(context),
            icon: const Icon(
              Icons.add,
            ))
      ],
    );
    final txListWidget = Container(
      height: (MediaQuery
          .of(context)
          .size
          .height -
          MediaQuery
              .of(context)
              .padding
              .top -
          MediaQuery
              .of(context)
              .padding
              .bottom -
          appbar.preferredSize.height) *
          1,
      child: TransactionList(_userTransaction, removeTransaction),
    );
    final body = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            if (isLandscape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Switch.adaptive(
                      value: _showChart,
                      onChanged: (val) {
                        setState(() {
                          _showChart = val;
                        });
                      }),
                   Text("Show Chart",style: Theme.of(context).textTheme.titleMedium,),
                ],
              ),
            if(!isLandscape)
              Container(
                height: (MediaQuery
                    .of(context)
                    .size
                    .height -
                    MediaQuery
                        .of(context)
                        .padding
                        .top -
                    MediaQuery
                        .of(context)
                        .padding
                        .bottom -
                    appbar.preferredSize.height) *
                    0.3,
                child: Chart(_recentTransactions),
              ),
            if(!isLandscape)txListWidget,
            if(isLandscape)
              _showChart
                  ? Container(
                height: (MediaQuery
                    .of(context)
                    .size
                    .height -
                    MediaQuery
                        .of(context)
                        .padding
                        .top -
                    MediaQuery
                        .of(context)
                        .padding
                        .bottom -
                    appbar.preferredSize.height) *
                    0.7,
                child: Chart(_recentTransactions),
              )
                  : txListWidget
          ],
        ),
      ),
    );
    return Platform.isIOS
        ? CupertinoPageScaffold(navigationBar:appbar,child: body,)
        : Scaffold(
      appBar: appbar,
      body: body,
      floatingActionButton: (Platform.isAndroid) ? FloatingActionButton(
        onPressed: () => startAddNewTransaction(context),
        child: Icon(Icons.add),
      ) : Container(),
    );
  }
}

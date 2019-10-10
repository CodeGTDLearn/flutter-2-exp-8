import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'entity/transaction.dart';
import 'widget/chart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My last Expense App', home: MyHomeApp(),

      //ThemeData
      theme: ThemeData(
        //General parameters
        primarySwatch: Colors.amber,
        accentColor: Colors.deepOrangeAccent,
        fontFamily: 'QuickSand',

        //Text Theme
        textTheme: ThemeData.light().textTheme.copyWith(
              //textTheme title customization
              title: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 18,
                  fontWeight: FontWeight.bold),

              //textTheme button customization
              button: TextStyle(fontFamily: 'QuickSand', color: Colors.brown),
            ),

        //AppBar Theme
        appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(

                //Appbar TextTheme customization
                title: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'OpenSans'),

                //Appbar textbutton customization
                button: TextStyle(color: Colors.white))),
      ),
    );
  }
}

class MyHomeApp extends StatefulWidget {
  @override
  _MyHomeAppState createState() => _MyHomeAppState();
}

class _MyHomeAppState extends State<MyHomeApp> {
  final List<Transaction> _listTransaction = [
    Transaction(
      id: 't1',
      title: 'New Shoes',
      amount: 69.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'New Hat',
      amount: 99.99,
      date: DateTime.now(),
    ),
  ];

  void deleteTxDAO(String id) {
    setState(() {
      _listTransaction.removeWhere((tx) => tx.id == id);
    });
  }

  void createTxDAO(
    String title,
    double amount,
    DateTime date,
  ) {
    final newTx = Transaction(
        title: title,
        amount: amount,
        date: date,
        id: DateTime.now().toString());
    setState(() {
      _listTransaction.add(newTx);
    });
  }

  List<Transaction> get _last7DaysTx {
    return _listTransaction.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void showAddModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return GestureDetector(
            behavior: HitTestBehavior.opaque, onTap: () {},
            //child: NewTransaction(createTxDAO),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Expenses 8'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => showAddModal(context),
          ),
        ],
      ),
      body:Column(
        children: <Widget>[
          Chart(_last7DaysTx),
          //TransactionList(_listTransaction, deleteTxDAO);
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showAddModal(context),
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

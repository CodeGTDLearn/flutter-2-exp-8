import 'package:flutter/material.dart';

import 'entity/transaction.dart';
import 'widget/chart.dart';
import 'widget/newTransaction.dart';
import 'widget/transactioList.dart';

void main() {
//  SystemChrome.setPreferredOrientations([
//    DeviceOrientation.portraitUp,
//    DeviceOrientation.portraitUp,
//  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My last Expense App',
      home: MyHomeApp(),
      debugShowCheckedModeBanner: false,

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

  bool _showChart = false;

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
            onTap: () {},
            child: NewTransaction(createTxDAO),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text('Personal Expenses 8'),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => showAddModal(context),
        ),
      ],
    );

    //Taking the App usefulArea
<<<<<<< HEAD
    // size.height => body area
=======
    // size.height => Sccafold Body area
>>>>>>> feat-refact-mediaqueries
    // appBar.preferredSize.height => topbar height
    // padding.top => Status Bar height
    final usefulArea =
        (MediaQuery.of(context).size.height - appBar.preferredSize.height) -
            MediaQuery.of(context).padding.top;

<<<<<<< HEAD
=======
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

>>>>>>> feat-refact-mediaqueries
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
<<<<<<< HEAD
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(_showChart ? 'List' : 'Chart'),
                Switch(
                    value: _showChart,
                    onChanged: (val) {
                      setState(() {
                        _showChart = val;
                      });
                    })
              ],
            ),
            _showChart
                ? Container(
                    height: usefulArea * 0.3,
                    child: Chart(_last7DaysTx),
                  )
                : Container(
                    height: usefulArea * 0.7,
                    child: TransactionList(_listTransaction, deleteTxDAO),
                  ),
=======
            if (isLandscape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(_showChart ? 'List' : 'Chart'),
                  Switch(
                      value: _showChart,
                      onChanged: (val) {
                        setState(() {
                          _showChart = val;
                        });
                      })
                ],
              ),
            if (isLandscape)
              _showChart
                  ? Container(
                      height: usefulArea * 0.7,
                      child: Chart(_last7DaysTx),
                    )
                  : Container(
                      height: usefulArea * 0.7,
                      child: TransactionList(_listTransaction, deleteTxDAO),
                    ),
            if (!isLandscape)
              Container(
                height: usefulArea * 0.3,
                child: Chart(_last7DaysTx),
              ),
            if (!isLandscape)
              Container(
                height: usefulArea * 0.7,
                child: TransactionList(_listTransaction, deleteTxDAO),
              ),
>>>>>>> feat-refact-mediaqueries
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showAddModal(context),
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

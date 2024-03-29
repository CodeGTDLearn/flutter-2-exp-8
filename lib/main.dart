import 'dart:io';

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
                fontWeight: FontWeight.bold,
              ),

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

//WidgetsBindingObserver: To use App Lifecycle(LF)
class _MyHomeAppState extends State<MyHomeApp> with WidgetsBindingObserver {
  //App LF method -- Add 'App LF listener'
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  //App LF method -- This method uses a 'App LF listener' (added above)
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print(state);
    super.didChangeAppLifecycleState(state);
  }

  //App LF method -- Remove 'App LF listener'
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

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
    print('Build - Main');
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
    // size.height => Sccafold Body area
    // appBar.preferredSize.height => topbar height
    // padding.top => Status Bar height
    final usefulArea =
        (MediaQuery.of(context).size.height - appBar.preferredSize.height) -
            MediaQuery.of(context).padding.top;

    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            if (isLandscape) ...buildLandscapeContent(usefulArea),
            if (!isLandscape) ...buildPortraitContent(usefulArea),
          ],
        ),
      ),
      floatingActionButton: Platform.isAndroid
          ? FloatingActionButton(
              onPressed: () => showAddModal(context),
              child: Icon(Icons.add),
            )
          : Container(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  List<Widget> buildLandscapeContent(double usefulArea) {
    final double proportion = 0.7;

    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(_showChart ? 'List' : 'Chart'),
          Switch.adaptive(
              activeColor: Theme.of(context).accentColor,
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
              height: usefulArea * proportion,
              child: Chart(_last7DaysTx),
            )
          : Container(
              height: usefulArea * proportion,
              child: TransactionList(
                _listTransaction,
                deleteTxDAO,
              ),
            )
    ];
  }

  List<Widget> buildPortraitContent(double usefulArea) {
    final double chartElementProportion = 0.3;
    final double listElementProportion = 0.7;

    return [
      Container(
        height: usefulArea * chartElementProportion,
        child: Chart(_last7DaysTx),
      ),
      Container(
        height: usefulArea * listElementProportion,
        child: TransactionList(_listTransaction, deleteTxDAO),
      )
    ];
  }
}

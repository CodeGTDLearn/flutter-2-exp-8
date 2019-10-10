import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

import 'dart:math';

import 'package:exp8/entity/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Transaction_item_Card extends StatefulWidget {
  final Transaction _transaction;
  final Function deleteTxDAO;

  const Transaction_item_Card({
    Key key,
    @required Transaction transaction,
    @required this.deleteTxDAO,
  })  : _transaction = transaction,
        super(key: key);

  @override
  _Transaction_item_CardState createState() => _Transaction_item_CardState();
}

class _Transaction_item_CardState extends State<Transaction_item_Card> {
  Color _bgColor;

  @override
  void initState() {
    const availableColors = [
      Colors.red,
      Colors.purpleAccent,
      Colors.amberAccent,
    ];

    _bgColor = availableColors[Random().nextInt(3)];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      margin: EdgeInsets.all(5),
      child: ListTile(
          leading: CircleAvatar(
            backgroundColor: _bgColor,
            radius: 30,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FittedBox(child: Text("\$${widget._transaction.amount}")),
            ),
          ),
          title: Text(
            widget._transaction.title,
            style: Theme.of(context).textTheme.title,
          ),
          subtitle: Text(DateFormat.yMMMd().format(widget._transaction.date)),
          trailing: MediaQuery.of(context).size.width > 460
              ? FlatButton.icon(
                  icon: Icon(Icons.delete),
                  label: Text('Delete'),
                  textColor: Theme.of(context).errorColor,
                  onPressed: () => widget.deleteTxDAO(widget._transaction.id),
                )
              : IconButton(
                  icon: Icon(Icons.delete),
                  color: Theme.of(context).errorColor,
                  onPressed: () => widget.deleteTxDAO(widget._transaction.id),
                )),
    );
  }
}

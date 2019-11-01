import 'package:exp8/entity/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Transaction_Item_Card extends StatelessWidget {
  final Transaction _transaction;
  final Function deleteTxDAO;

  const Transaction_Item_Card({
    Key key,
    @required Transaction transaction,
    @required this.deleteTxDAO,
  })  : _transaction = transaction,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      margin: EdgeInsets.all(5),
      child: ListTile(
          leading: CircleAvatar(
            radius: 30,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FittedBox(child: Text("\$${_transaction.amount}")),
            ),
          ),
          title: Text(
            _transaction.title,
            style: Theme.of(context).textTheme.title,
          ),
          subtitle: Text(DateFormat.yMMMd().format(_transaction.date)),
          trailing: MediaQuery.of(context).size.width > 460
              ? FlatButton.icon(
                  icon: Icon(Icons.delete),
                  label: Text('Delete'),
                  textColor: Theme.of(context).errorColor,
                  onPressed: () => deleteTxDAO(_transaction.id),
                )
              : IconButton(
                  icon: Icon(Icons.delete),
                  color: Theme.of(context).errorColor,
                  onPressed: () => deleteTxDAO(_transaction.id),
                )),
    );
  }
}

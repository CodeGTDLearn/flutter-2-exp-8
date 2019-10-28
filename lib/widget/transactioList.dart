import 'package:exp8/entity/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final Function deleteTxDAO;
  final List<Transaction> _listTransaction;

  TransactionList(this._listTransaction, this.deleteTxDAO);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 450,
      child: _listTransaction.isEmpty
          ? LayoutBuilder(builder: (ctx, constraints) {
              return Column(
                children: <Widget>[
                  Text('No items yet'),
                  SizedBox(height: 10),
                  Container(
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              );
            })
          : ListView.builder(
              itemCount: _listTransaction.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 8,
                  margin: EdgeInsets.all(5),
                  child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FittedBox(
                              child:
                                  Text("\$${_listTransaction[index].amount}")),
                        ),
                      ),
                      title: Text(
                        _listTransaction[index].title,
                        style: Theme.of(context).textTheme.title,
                      ),
                      subtitle: Text(DateFormat.yMMMd()
                          .format(_listTransaction[index].date)),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        color: Theme.of(context).errorColor,
                        onPressed: () =>
                            deleteTxDAO(_listTransaction[index].id),
                      )),
                );
              },
            ),
    );
  }
}

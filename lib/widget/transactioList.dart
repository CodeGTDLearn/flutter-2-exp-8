import 'package:flutter/material.dart';


class TransactionList extends StatelessWidget {
  final Function deleteTxDAO;


  @override
  Widget build(BuildContext context) {
    print('Build - Transaction List');
    return Container(
      height: 450,
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
                      trailing: MediaQuery.of(context).size.width > 460
                          ? FlatButton.icon(
                              icon: Icon(Icons.delete),
                              label: Text('Delete'),
                              textColor: Theme.of(context).errorColor,
                              onPressed: () =>
                                  deleteTxDAO(_listTransaction[index].id),
                            )
                          : IconButton(
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

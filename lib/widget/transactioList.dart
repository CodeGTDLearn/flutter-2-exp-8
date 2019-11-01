import 'package:flutter/material.dart';

import './transaction_item_card.dart';
import '../entity/transaction.dart';

class TransactionList extends StatelessWidget {
  final Function deleteTxDAO;
  final List<Transaction> _transaction;

  TransactionList(this._transaction, this.deleteTxDAO);

  @override
  Widget build(BuildContext context) {
    print('Build - Transaction List');
    return Container(
      height: 450,
      child: _transaction.isEmpty
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
              itemCount: _transaction.length,
              itemBuilder: (context, index) {
                return Transaction_item_card(
                  transaction: _transaction[index],
                  deleteTxDAO: deleteTxDAO,
                );
              },
            ),
    );
  }
}

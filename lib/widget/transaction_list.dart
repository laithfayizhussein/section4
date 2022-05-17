import 'package:flutter/material.dart';
import './transaction_item.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions; // how this used
  TransactionList(this.transactions, this.deleteTx);
  final Function deleteTx;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      // i change the list view and map over it cos if add key it will be change when ever state change
      // as the random background color
      // but with value every element make connected with widget and
      // flutter will not delete the element and keep the state cos theres another element
      child: ListView(
        children: transactions
            .map((tx) => TransactionItem(
                key: ValueKey(tx.id), transaction: tx, deleteTx: deleteTx))
            .toList(), // i use map to transform this list of obj to list of widget
      ),
    );
  }
}

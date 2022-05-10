import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  TransactionList(this.transactions);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      child: ListView.builder(
        itemBuilder: (ctx, index) {
          return Card(
              child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                decoration: BoxDecoration(
                    border: Border.all(
                  color: Colors.grey,
                  width: 2,
                )),
                child: Text(
                  '\$${transactions[index].amount}',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0,
                  ),
                ),
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      transactions[index].title,
                      style: Theme.of(context).appBarTheme.titleTextStyle,
                    ),
                    Text(DateFormat.yMMMMd().format(transactions[index].date!)),
                  ],
                ),
              )
            ],
          ));
        },
        itemCount: transactions.length,
        // i use map to transform this list of obj to list of widget
      ),
    );
  }
}

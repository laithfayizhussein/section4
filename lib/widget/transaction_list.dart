import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions; // how this used
  TransactionList(this.transactions, this.deleteTx);
  final Function deleteTx;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      child: ListView.builder(
        itemBuilder: (ctx, index) {
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
            elevation: 5,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.primary,
                radius: 30,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child:
                      FittedBox(child: Text('\$${transactions[index].amount}')),
                ),
              ),
              title: Text(
                '${transactions[index].title}',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              subtitle:
                  Text(DateFormat.yMMMd().format(transactions[index].date!)),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                color: Theme.of(context).colorScheme.error,
                // didn't use the function word property just cos i need to pass the id to the function and onpressed doesn't take function
                // so i need to make anonymous function and force it to take it
                onPressed: () => deleteTx(transactions[index].id),
              ),
            ),
          );
        },
        itemCount: transactions.length,
        // i use map to transform this list of obj to list of widget
      ),
    );
  }
}

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionItem extends StatefulWidget {
  const TransactionItem({
    Key? key,
    required this.transaction,
    required this.deleteTx,
  }) : super(key: key);

  final Transaction transaction;
  final Function deleteTx;

  @override
  State<TransactionItem> createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  late Color randomColor;

  @override
  void initState() {
    const availableColors = [
      Colors.amber,
      Colors.blue,
      Colors.red,
      Colors.grey
    ];

    randomColor = availableColors[Random().nextInt(4)];
    print(randomColor);
    print('777777777777777777777777777777777777777777777777');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
      elevation: 5,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: randomColor,
          radius: 30,
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: FittedBox(child: Text('\$${widget.transaction.amount}')),
          ),
        ),
        title: Text(
          '${widget.transaction.title}',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        subtitle: Text(DateFormat.yMMMd().format(widget.transaction.date!)),
        trailing: IconButton(
          icon: Icon(Icons.delete),
          color: Theme.of(context).colorScheme.error,
          // didn't use the function word property just cos i need to pass the id to the function and onpressed doesn't take function
          // so i need to make anonymous function and force it to take it
          onPressed: () => widget.deleteTx(widget.transaction.id),
        ),
      ),
    );
  }
}

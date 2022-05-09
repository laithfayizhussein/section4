import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;
  NewTransaction(this.addTx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  // create the fun for use it 3 times and to get the submit when the two fields is fill
  void submitData() {
    final enterdTitle = titleController.text;
    final enterdAmount = double.parse(amountController.text);
    if (enterdTitle.isEmpty || enterdAmount < 0) {
      return;
    }
    widget.addTx(titleController.text, double.parse(amountController.text));
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: titleController,
              onSubmitted: (_) =>
                  submitData, // should add anonymous fuc and the underscore for telling my self that i
              // didnt use it its just to flutter
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => submitData,
            ),
            TextButton(
                style: TextButton.styleFrom(
                  primary: Colors.purple,
                  onSurface: Colors.grey,
                ),
                child: Text('add something '),
                onPressed: submitData)
          ],
        ),
      ),
    );
  }
}

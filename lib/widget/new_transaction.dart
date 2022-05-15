import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();
  DateTime? selectedDate;

  // create the fun for use it 3 times and to get the submit when the two fields is fill
  void submitData() {
    final enterdTitle = titleController.text;
    final enterdAmount = double.parse(amountController.text);
    if (enterdTitle.isEmpty || enterdAmount < 0 || selectedDate == null) {
      return;
    }
    widget.addTx(titleController.text, double.parse(amountController.text),
        selectedDate);
    Navigator.of(context).pop();
  }

  void datePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        selectedDate = pickedDate;
      });
    });
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
              // didn't use it its just to flutter
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => submitData,
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              width: 250,
              child: Divider(
                color: Colors.black,
              ),
            ),
            Container(
              height: 70,
              child: Row(
                children: [
                  Expanded(
                    child: Text(selectedDate == null
                        ? 'no date choice '
                        : 'picked date :${DateFormat.yMMMd().format(selectedDate!)}'),
                  ),
                  TextButton(onPressed: datePicker, child: Text('choose Date')),
                ],
              ),
            ),
            TextButton(
                style: TextButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: Theme.of(context).colorScheme.primary,
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

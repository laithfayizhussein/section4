import 'dart:io';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:section4/widget/chart.dart';
import './widget/new_transaction.dart';
import './widget/transaction_list.dart';
import './widget/chart.dart';
import './models/transaction.dart';

void main() {
  // to stop landscape
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'personal expenses',
      theme: ThemeData(
          appBarTheme: AppBarTheme(
              titleTextStyle: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          )),
          fontFamily: 'Quicksand',
          colorScheme: ColorScheme(
            brightness: Brightness.light,
            primary: Colors.purple,
            onPrimary: Colors.white,
            secondary: Colors.amber,
            onSecondary: Colors.white,
            error: Colors.red,
            onError: Colors.white,
            background: Colors.white,
            onBackground: Colors.black,
            surface: Colors.amber,
            onSurface: Colors.black,
          )),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransaction = [
    // Transaction(
    //   title: 'eges',
    //   id: 'n1',
    //   amount: 50,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   title: 'nsn',
    //   id: 'n2',
    //   amount: 100,
    //   date: DateTime.now(),
    // )
  ];

  List<Transaction> get _recentTransaction {
    return _userTransaction.where((element) {
      return element.date!.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

// this 3 parameters take from the newTransaction page
  // i got idea the page that has constructor it will pass the data of the other page
  void _addNewTransactions(
      String txTitle, double txAmount, DateTime chosenDate) {
    final newTx = Transaction(
        title: txTitle,
        id: DateTime.now().toString(),
        amount: txAmount,
        date: chosenDate);
    setState(() {
      _userTransaction.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return NewTransaction(
            _addNewTransactions,
          );
        });
  }

  void deleteTransaction(String id) {
    setState(() {
      _userTransaction.removeWhere((element) => element.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final PreferredSizeWidget
        appBar; // use it cos the both app bar have preferredsize to be able to use it in line 157 it should declare it like this
    if (Platform.isIOS) {
      appBar = CupertinoNavigationBar(
        middle: Text(
          'personal expenses',
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              child: Icon(CupertinoIcons.add),
              onTap: () => _startAddNewTransaction(context),
            )
          ],
        ),
      );
    } else {
      appBar = AppBar(
        title: Text(
          'personal expenses',
          style: TextStyle(fontFamily: 'OpenSans'),
        ),
        actions: [
          IconButton(
              onPressed: () => _startAddNewTransaction(context),
              icon: Icon(Icons.add))
        ],
      );
    }
    final bodyPage = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // wrap chart and translist in container to give it height to prevent the scroll
            // i did the minus  method and to make the size dynamic in any mobile
            Container(
                height: (mediaQuery.size.height -
                        appBar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.3,
                child: Chart(_recentTransaction)),
            Container(
                height: (mediaQuery.size.height -
                        appBar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.7,
                child: TransactionList(_userTransaction, deleteTransaction)),
          ],
        ),
      ),
    );
    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: bodyPage,
          )
        : Scaffold(
            appBar: appBar,
            body: bodyPage,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () {
                      _startAddNewTransaction(context);
                    },
                  ),
          );
  }
}

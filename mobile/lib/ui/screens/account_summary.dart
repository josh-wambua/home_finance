import 'package:flutter/material.dart';
import 'package:homefinance/models/account.dart';
import 'package:homefinance/models/user.dart';
import 'package:intl/intl.dart';

class AccountSummaryScreen extends StatefulWidget {
  final Account account;
  final User user;

  AccountSummaryScreen({this.account, this.user});
  static final String id = 'edit_account';
  @override
  _AccountSummaryScreenState createState() => _AccountSummaryScreenState();
}

class _AccountSummaryScreenState extends State<AccountSummaryScreen> {
  final currencyFormatter = new NumberFormat("#,##0.00", "en_US");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.account.accountName),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.edit),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.delete),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 20, left: 1),
        child: Column(
          children: <Widget>[
            Text("ALL TRANSACTIONS"),
            Padding(
              padding: EdgeInsets.only(left: 20.0, top: 10, right: 20),
              child: Column(
                children: <Widget>[
                  Row(children: <Widget>[
                      Expanded(child: Text("As Of " + DateFormat("dd MMM yyyy").format(widget.account.dateCreated.toDate()) )), Text(currencyFormatter.format(widget.account.openingBalance) + " " + widget.account.currency)
                    ],),
                  Row(children: <Widget>[
                      Expanded(child: Text("   + Funds In")), Text(currencyFormatter.format(widget.account.allCredits) + " " + widget.account.currency, style: TextStyle(color: Colors.green),)
                    ],),
                  Row(children: <Widget>[
                      Expanded(child: Text("   +Funds Out")), Text(currencyFormatter.format(widget.account.allDebits) + " " + widget.account.currency, style: TextStyle(color: Colors.red))
                    ],),
                  Row(children: <Widget>[
                      Expanded(child: Text("Current Balance")), Text(currencyFormatter.format(widget.account.currentBalance) + " " + widget.account.currency),
                    
                    ],),
                    Divider(),
                    SizedBox(),
                    Divider(),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text("Add Income", style: TextStyle(fontSize: 20, color: Colors.blue),),
                        Expanded(child: Text("Add Expense", style: TextStyle(fontSize: 20, color: Colors.blue), textAlign: TextAlign.center,)),
                        Text("View Month", style: TextStyle(fontSize: 20, color: Colors.blue))
                      ],
                    )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}